# macOS /etc/zprofile runs path_helper, which moves the system dirs from
# /etc/paths and /etc/paths.d (/usr/local/bin, /usr/bin, ...) ahead of the rest
# of PATH. Move them back behind our own dirs. Rebuilt from PATH alone because
# Codex command shells (zsh -lc plus a replayed snapshot) don't see variables
# set in .zshenv.
typeset -U path
() {
  local f sys=(${(f)"$(</etc/paths)"})
  for f in /etc/paths.d/*(N); sys+=(${(f)"$(<$f)"})
  path=(${path:|sys} ${path:*sys})
}
