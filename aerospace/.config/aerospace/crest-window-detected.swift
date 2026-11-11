// Compiled and run by crest-window-detected.sh for every new Crest window, which AeroSpace
// names in AEROSPACE_WINDOW_ID. Exits 0 for a browser window, which the Crest rule in
// aerospace.toml then tiles on A, and 1 for a Quick Window or anything else, which stays
// floating.
//
// Crest's browser windows and Quick Windows share an app id, a role and a title scheme, so
// AeroSpace cannot tell them apart. Their content can: a browser window holds an element
// identified as "browser-window-<uuid>", a Quick Window holds "quick-window-*" controls.
//
// A Quick Window is also put where its link was opened, which Crest and AeroSpace get wrong
// in two ways. See workspaceLinkWasOpenedOn for the workspace and place for the position.
//
// The window stays where it opened until this has run, so the run is kept short. Nearly all
// of it is first contact with the accessibility API and with the window server, about 30 ms
// each, which is why the two overlap and why nothing else asks the window server anything.

import AppKit

// AeroSpace's window ids are CGWindowIDs, which only this private call maps to AX windows.
@_silgen_name("_AXUIElementGetWindow")
func _AXUIElementGetWindow(_ element: AXUIElement, _ id: UnsafeMutablePointer<CGWindowID>) -> AXError

enum WindowKind { case browser, quick }

let crestBundleID = "com.pauldavis.crest"
// The markers sit two and three levels below the window. The page content starts at four.
let markerDepth = 3
// A new window's content shows up shortly after AeroSpace detects it.
let timeout: TimeInterval = 3
// How long a Quick Window is watched, after it was last changed, for Crest or AeroSpace still
// moving it or the pointer, and how long that may go on at most.
let settleTime: TimeInterval = 0.15
let settleLimit: TimeInterval = 1
// How long a moved window may take to glide to its new position before it is resized anyway,
// and how often its progress is checked.
let glideTimeout: TimeInterval = 0.5
let glidePollInterval: useconds_t = 5_000
// How long after a workspace switch a new Quick Window still counts as opened by its cause.
// Crest 0.9.1 creates the window about 220 ms after the switch, and this checks about 300 ms
// after it. Switching by hand and then opening one takes longer than this.
let switchRecency: TimeInterval = 1
// How far a Quick Window opening where another already is moves, and how many such steps it
// takes at most. These are Crest's own values.
let cascadeStep: CGFloat = 22
let cascadeLimit = 8
let pollInterval: useconds_t = 10_000

extension CGRect {
    var center: CGPoint { CGPoint(x: midX, y: midY) }
}

func attribute<Value>(_ element: AXUIElement, _ name: String) -> Value? {
    var value: CFTypeRef?
    AXUIElementCopyAttributeValue(element, name as CFString, &value)
    return value as? Value
}

func children(of element: AXUIElement) -> [AXUIElement] {
    attribute(element, kAXChildrenAttribute) ?? []
}

// Crest's windows, with the window ids AeroSpace knows them by.
func windows(of apps: [AXUIElement]) -> [(id: CGWindowID, element: AXUIElement)] {
    apps.flatMap { attribute($0, kAXWindowsAttribute) as [AXUIElement]? ?? [] }.compactMap { window in
        var id: CGWindowID = 0
        return _AXUIElementGetWindow(window, &id) == .success ? (id, window) : nil
    }
}

func window(_ id: CGWindowID, in apps: [AXUIElement]) -> AXUIElement? {
    windows(of: apps).first { $0.id == id }?.element
}

// Searches level by level, which reaches a marker in the fewest calls and stops above the
// page content.
func kind(of window: AXUIElement) -> WindowKind? {
    var level = [window]
    for depth in 0...markerDepth {
        for element in level {
            guard let identifier: String = attribute(element, kAXIdentifierAttribute) else { continue }
            if identifier.hasPrefix("browser-window-") { return .browser }
            if identifier.hasPrefix("quick-window-") { return .quick }
        }
        if depth < markerDepth { level = level.flatMap(children) }
    }
    return nil
}

// Opening a link activates Crest, and macOS first focuses the Crest window last in use.
// AeroSpace follows that focus to the window's workspace, so the Quick Window opens there and
// not where the link was. The exec-on-workspace-change callback in aerospace.toml records
// every switch as "<window that took focus> <workspace left>". When the last switch is recent
// and went to a Crest window that is no Quick Window, this returns the workspace it left.
func workspaceLinkWasOpenedOn(crest: [AXUIElement]) -> String? {
    let record = NSTemporaryDirectory() + "aerospace-workspace-switch"
    guard let written = try? FileManager.default.attributesOfItem(atPath: record)[.modificationDate] as? Date,
          Date().timeIntervalSince(written) < switchRecency,
          let fields = (try? String(contentsOfFile: record, encoding: .utf8))?
              .split(separator: "\n").first?.split(separator: " ", maxSplits: 1),
          fields.count == 2, let id = CGWindowID(fields[0]),
          let focused = window(id, in: crest), kind(of: focused) != .quick else { return nil }
    return String(fields[1])
}

// Moves the window AeroSpace named to `workspace`, takes the focus along, and returns once
// AeroSpace has. Until then the Quick Windows already on `workspace` are parked off screen.
func moveToWorkspace(_ workspace: String) {
    let aerospace = Process()
    aerospace.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    aerospace.arguments = ["aerospace", "move-node-to-workspace", "--focus-follows-window", workspace]
    guard (try? aerospace.run()) != nil else { return }
    aerospace.waitUntilExit()
}

// Display bounds share the accessibility coordinate space: origin at the main display's top left.
func displayBounds() -> [CGRect] {
    var count: UInt32 = 0
    CGGetActiveDisplayList(0, nil, &count)
    var displays = [CGDirectDisplayID](repeating: 0, count: Int(count))
    CGGetActiveDisplayList(count, &displays, &count)
    return displays.map(CGDisplayBounds)
}

func frame(of window: AXUIElement) -> CGRect? {
    var frame = CGRect.zero
    guard let value: AXValue = attribute(window, "AXFrame"), AXValueGetValue(value, .cgRect, &frame) else { return nil }
    return frame
}

// The frames of the Quick Windows on `display` other than window `id`, front to back as
// Crest lists its windows. Those on hidden workspaces are parked off screen and minimized
// ones are out of sight, so neither counts.
func quickWindowFrames(on display: CGRect, besides id: CGWindowID, in apps: [AXUIElement]) -> [CGRect] {
    windows(of: apps).compactMap { other in
        guard other.id != id, attribute(other.element, kAXMinimizedAttribute) != true,
              let frame = frame(of: other.element), display.contains(frame.center),
              kind(of: other.element) == .quick else { return nil }
        return frame
    }
}

// The first free spot for a window of `size` on `display`: its center, else one cascade step
// at a time down and to the right, then up and to the left, while the window still fits. A
// spot is taken when another Quick Window is centered within half a step of it.
func freeSpot(for size: CGSize, on display: CGRect, clearOf taken: [CGPoint]) -> CGRect {
    let centered = CGRect(
        x: (display.midX - size.width / 2).rounded(), y: (display.midY - size.height / 2).rounded(),
        width: size.width, height: size.height)
    let steps = Array(0...cascadeLimit) + (1...cascadeLimit).map { -$0 }
    return steps.lazy
        .map { centered.offsetBy(dx: cascadeStep * CGFloat($0), dy: cascadeStep * CGFloat($0)) }
        .filter { display.contains($0) }
        .first { spot in
            !taken.contains { abs($0.x - spot.midX) < cascadeStep / 2 && abs($0.y - spot.midY) < cascadeStep / 2 }
        } ?? centered
}

// Where the window server shows window `id` now. The accessibility frame jumps to a new
// position at once, while macOS glides the window there over about 250 ms.
func shownOrigin(of id: CGWindowID) -> CGPoint? {
    let info = (CGWindowListCopyWindowInfo(.optionIncludingWindow, id) as? [[CFString: Any]])?.first
    guard let bounds = info?[kCGWindowBounds] as? NSDictionary else { return nil }
    return CGRect(dictionaryRepresentation: bounds)?.origin
}

// Sets window `id`, now at `current`, to `frame`, leaving what already matches alone, and says
// whether it changed anything. A resize during the glide to a new position starts from
// wherever the window is on the way and cancels the rest of the move, so it waits for the
// window to arrive. It moves first, so the window never grows past the screen's bottom edge,
// where macOS would cut it short.
func setFrame(of window: AXUIElement, id: CGWindowID, from current: CGRect, to frame: CGRect) -> Bool {
    var origin = frame.origin, size = frame.size
    let moves = abs(current.minX - origin.x) > 1 || abs(current.minY - origin.y) > 1
    let resizes = abs(current.width - size.width) > 1 || abs(current.height - size.height) > 1
    if moves, let value = AXValueCreate(.cgPoint, &origin) {
        AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, value)
    }
    if resizes, let value = AXValueCreate(.cgSize, &size) {
        let arrival = Date().addingTimeInterval(glideTimeout)
        while moves, Date() < arrival, let shown = shownOrigin(of: id),
              abs(shown.x - origin.x) > 1 || abs(shown.y - origin.y) > 1 {
            usleep(glidePollInterval)
        }
        AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString, value)
    }
    return moves || resizes
}

// Crest centers a Quick Window opened from another app over the frontmost window outside
// Crest, at 80% of its size. After a link click that is usually the JankyBorders border of
// Crest's own browser window, which AeroSpace parks off screen while A is hidden, so Crest
// pushes the window into the nearest corner of the screen. With a Quick Window already open,
// it is that window's border, so each new one is smaller than the last. This moves `window`
// to the first free spot on the display it overlaps most instead, at the size of the Quick
// Window in front there. Crest remembers a size given to a Quick Window and opens later ones
// at it, so after the first such resize its own sizes match as well.
//
// Crest places the window a few frames after creating it, AeroSpace's mouse-follows-focus
// sends the pointer after it, sometimes twice, and AeroSpace brings back the windows it had
// parked when the workspace returns. These normally come before this runs, but nothing orders
// them against it, so the window is watched for a moment: it is put back if it moves, it
// steps aside for Quick Windows that come back into view, and the pointer follows whenever it
// is left where the window had been.
func place(_ window: AXUIElement, id: CGWindowID, among apps: [AXUIElement]) {
    guard let opened = frame(of: window) else { return }
    func overlap(_ display: CGRect) -> CGFloat {
        let shared = display.intersection(opened)
        return shared.width * shared.height
    }
    guard let display = displayBounds().max(by: { overlap($0) < overlap($1) }) else { return }

    let limit = Date().addingTimeInterval(settleLimit)
    var settled = Date().addingTimeInterval(settleTime)
    repeat {
        if let current = frame(of: window) {
            let others = quickWindowFrames(on: display, besides: id, in: apps)
            let spot = freeSpot(for: others.first?.size ?? current.size, on: display, clearOf: others.map(\.center))
            if setFrame(of: window, id: id, from: current, to: spot) {
                settled = Date().addingTimeInterval(settleTime)
            }
            if let pointer = CGEvent(source: nil)?.location, opened.contains(pointer), !spot.contains(pointer) {
                CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: spot.center, mouseButton: .left)?
                    .post(tap: .cghidEventTap)
            }
        }
        usleep(pollInterval)
    } while Date() < min(settled, limit)
}

guard let id = ProcessInfo.processInfo.environment["AEROSPACE_WINDOW_ID"].flatMap(CGWindowID.init) else {
    FileHandle.standardError.write(Data("AEROSPACE_WINDOW_ID is not set to a window id\n".utf8))
    exit(2)
}

// Someone is waiting on this window, so run at the priority of user-facing work.
pthread_set_qos_class_self_np(QOS_CLASS_USER_INTERACTIVE, 0)

// A Quick Window needs the window server for the display layout. That contact starts now,
// beside the accessibility one, instead of after it.
DispatchQueue.global(qos: .userInteractive).async { _ = CGMainDisplayID() }

let crest = NSRunningApplication.runningApplications(withBundleIdentifier: crestBundleID)
    .map { AXUIElementCreateApplication($0.processIdentifier) }

let deadline = Date().addingTimeInterval(timeout)
repeat {
    if let window = window(id, in: crest) {
        switch kind(of: window) {
        case .browser: exit(0)
        case .quick:
            if let origin = workspaceLinkWasOpenedOn(crest: crest) { moveToWorkspace(origin) }
            place(window, id: id, among: crest)
            exit(1)
        case nil: break
        }
    }
    usleep(pollInterval)
} while Date() < deadline
exit(1)
