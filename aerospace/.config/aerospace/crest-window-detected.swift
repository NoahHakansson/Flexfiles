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
// in two ways. See workspaceLinkWasOpenedOn for the workspace and bringOnScreen for the place.
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
// How long a Quick Window is watched for Crest or AeroSpace still moving it or the pointer.
let settleTime: TimeInterval = 0.15
// How long after a workspace switch a new Quick Window still counts as opened by its cause.
// The two are 20 to 75 ms apart. Switching by hand and then opening one takes longer than this.
let switchRecency: TimeInterval = 0.3
let pollInterval: useconds_t = 10_000

func attribute<Value>(_ element: AXUIElement, _ name: String) -> Value? {
    var value: CFTypeRef?
    AXUIElementCopyAttributeValue(element, name as CFString, &value)
    return value as? Value
}

func children(of element: AXUIElement) -> [AXUIElement] {
    attribute(element, kAXChildrenAttribute) ?? []
}

func window(_ id: CGWindowID, in apps: [AXUIElement]) -> AXUIElement? {
    apps.lazy.flatMap { attribute($0, kAXWindowsAttribute) as [AXUIElement]? ?? [] }.first { window in
        var candidate: CGWindowID = 0
        return _AXUIElementGetWindow(window, &candidate) == .success && candidate == id
    }
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

// Moves the window AeroSpace named to `workspace` and takes the focus along.
func moveToWorkspace(_ workspace: String) {
    let aerospace = Process()
    aerospace.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    aerospace.arguments = ["aerospace", "move-node-to-workspace", "--focus-follows-window", workspace]
    try? aerospace.run()
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

// Crest opens a Quick Window over the frontmost window of another app, and takes for that the
// JankyBorders border of its own browser window, which AeroSpace keeps parked off screen
// while workspace A is hidden. This centers `window` on the display it overlaps most, unless
// a display already holds all of it, and returns the frame it left and its new center.
func bringOnScreen(_ window: AXUIElement) -> (from: CGRect, center: CGPoint)? {
    guard let frame = frame(of: window) else { return nil }
    let displays = displayBounds()
    func overlap(_ display: CGRect) -> CGFloat {
        let shared = display.intersection(frame)
        return shared.width * shared.height
    }
    guard !displays.contains(where: { $0.contains(frame) }),
          let display = displays.max(by: { overlap($0) < overlap($1) }) else { return nil }

    var origin = CGPoint(x: display.midX - frame.width / 2, y: display.midY - frame.height / 2)
    guard let position = AXValueCreate(.cgPoint, &origin) else { return nil }
    AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, position)
    return (frame, CGPoint(x: display.midX, y: display.midY))
}

// Crest places a Quick Window once, a few frames after creating it, and AeroSpace's
// mouse-follows-focus sends the pointer after it, sometimes twice. Both normally come before
// this runs, but nothing orders them against it, so the window is watched for a moment: it is
// moved back once, and the pointer follows whenever it is sent to where the window had been.
func keepOnScreen(_ window: AXUIElement) {
    let settled = Date().addingTimeInterval(settleTime)
    var move: (from: CGRect, center: CGPoint)?
    repeat {
        move = move ?? bringOnScreen(window)
        if let move, let pointer = CGEvent(source: nil)?.location, move.from.contains(pointer) {
            CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: move.center, mouseButton: .left)?
                .post(tap: .cghidEventTap)
        }
        usleep(pollInterval)
    } while Date() < settled
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
            keepOnScreen(window)
            exit(1)
        case nil: break
        }
    }
    usleep(pollInterval)
} while Date() < deadline
exit(1)
