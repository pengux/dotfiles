local wezterm = require 'wezterm'
local act = wezterm.action
return {
  -- font = wezterm.font("JetBrains Mono"),
  color_scheme = "tokyonight",
  window_background_opacity = 0.9,
  hide_tab_bar_if_only_one_tab = true,
  leader = { key = "z", mods = "ALT" },
  keys = {
    -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the tab
    { key = "v", mods = "ALT", action = act.Paste },

    -- Open/Close
    { key = "c", mods = "LEADER", action = act{ SpawnTab = "CurrentPaneDomain"} },
    { key = "x", mods = "LEADER", action = act{ CloseCurrentPane = { confirm = false } } },
    { key = "X", mods = "LEADER", action = act{ CloseCurrentTab = { confirm = false } } },


    -- Navigation
    { key = "h", mods = "CTRL|SHIFT", action = act{ ActivatePaneDirection = "Left" } },
    { key = "j", mods = "CTRL|SHIFT", action = act{ ActivatePaneDirection = "Down" } },
    { key = "k", mods = "CTRL|SHIFT", action = act{ ActivatePaneDirection = "Up" } },
    { key = "l", mods = "CTRL|SHIFT", action = act{ ActivatePaneDirection = "Right" } },
    { key = 'h', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = 'l', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = "t", mods = "LEADER", action = "ShowTabNavigator" },

    -- Resize
    { key = "H", mods = "LEADER", action = act{ AdjustPaneSize = { "Left", 5 } } },
    { key = "J", mods = "LEADER", action = act{ AdjustPaneSize = { "Down", 5 } } },
    { key = "K", mods = "LEADER", action = act{ AdjustPaneSize = { "Up", 5 } } },
    { key = "L", mods = "LEADER", action = act{ AdjustPaneSize = { "Right", 5 } } },

    -- Split
    { key = "v", mods = "LEADER", action = act{ SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "s", mods = "LEADER", action = act{ SplitVertical = { domain = "CurrentPaneDomain" } } },

    -- Copy/Select
    { key = "c", mods = "ALT",  action = "ActivateCopyMode" },
    { key = "C", mods = "ALT",  action = "QuickSelect" },

    -- Debug
    { key = "d", mods = "LEADER", action = "ShowDebugOverlay" },
  },
  unix_domains = {
    {
      name = 'unix',
    },
  },
  default_gui_startup_args = { 'connect', 'unix' },

  skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'fish',
    'tmux',
    'htop',
    'acpi',
    'df',
  },
}
