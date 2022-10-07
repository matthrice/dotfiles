local wezterm = require 'wezterm'

return {
  font = wezterm.font 'JetBrains Mono',
  font_size = 12.5,
  color_scheme = "VSCodeDark+ (Gogh)",
  default_cwd = "~/notes",
  hide_tab_bar_if_only_one_tab = true,
  audible_bell = "Disabled",
}
