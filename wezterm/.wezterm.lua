local wezterm = require 'wezterm'

return {
  font = wezterm.font 'JetBrains Mono',
  font_size = 12.5,
  color_scheme = "Catppuccin Frappe",
  default_cwd = "$HOME/notes",
  hide_tab_bar_if_only_one_tab = true,
  audible_bell = "Disabled"
}
