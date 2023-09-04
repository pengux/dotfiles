local wezterm = require 'wezterm'
local act = wezterm.action

local copy_mode = nil
if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  -- Enter search mode to edit the pattern.
  -- When the search pattern is an empty string the existing pattern is preserved
  table.insert(copy_mode, { key = "/", mods = "SHIFT", action = act { Search = { CaseInSensitiveString = "" } } })
  table.insert(copy_mode, { key = "n", mods = "NONE", action = wezterm.action { CopyMode = "NextMatch" } })
  table.insert(copy_mode, { key = "N", mods = "SHIFT", action = wezterm.action { CopyMode = "PriorMatch" } })
  table.insert(copy_mode, { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' })

  search_mode = wezterm.gui.default_key_tables().search_mode
  table.insert(search_mode, { key = "Escape", mods = "NONE", action = wezterm.action { CopyMode = "Close" } })
  table.insert(search_mode, { key = "Enter", mods = "NONE", action = "ActivateCopyMode" })
end

return {
  font = wezterm.font("IntelOne Mono"),
  font_size = 11,
  color_scheme = "Tokyo Night (Gogh)",
  window_background_opacity = 0.9,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  tab_max_width = 100,
  use_fancy_tab_bar = false,
  leader = { key = "z", mods = "ALT" },
  window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
  },
  keys = {
    -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the tab
    { key = "v", mods = "ALT",        action = act.PasteFrom 'Clipboard' },

    -- Open/Close
    { key = "c", mods = "LEADER",     action = act { SpawnTab = "CurrentPaneDomain" } },
    { key = "x", mods = "LEADER",     action = act { CloseCurrentPane = { confirm = false } } },
    { key = "w", mods = "LEADER",     action = act { CloseCurrentTab = { confirm = false } } },


    -- Navigation
    { key = "h", mods = "CTRL|SHIFT", action = act { ActivatePaneDirection = "Left" } },
    { key = "j", mods = "CTRL|SHIFT", action = act { ActivatePaneDirection = "Down" } },
    { key = "k", mods = "CTRL|SHIFT", action = act { ActivatePaneDirection = "Up" } },
    { key = "l", mods = "CTRL|SHIFT", action = act { ActivatePaneDirection = "Right" } },
    { key = 'h', mods = 'ALT',        action = act.ActivateTabRelative(-1) },
    { key = 'l', mods = 'ALT',        action = act.ActivateTabRelative(1) },
    { key = "t", mods = "LEADER",     action = "ShowTabNavigator" },

    -- Resize
    { key = "H", mods = "LEADER",     action = act { AdjustPaneSize = { "Left", 5 } } },
    { key = "J", mods = "LEADER",     action = act { AdjustPaneSize = { "Down", 5 } } },
    { key = "K", mods = "LEADER",     action = act { AdjustPaneSize = { "Up", 5 } } },
    { key = "L", mods = "LEADER",     action = act { AdjustPaneSize = { "Right", 5 } } },

    -- Split
    { key = "v", mods = "LEADER",     action = act { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "s", mods = "LEADER",     action = act { SplitVertical = { domain = "CurrentPaneDomain" } } },

    -- Copy/Select
    { key = "c", mods = "ALT",        action = "ActivateCopyMode" },
    { key = "C", mods = "ALT",        action = "QuickSelect" },
    {
      key = 'I',
      mods = 'CTRL',
      action = wezterm.action.QuickSelectArgs {
        label = 'open url',
        patterns = {
          'https?://\\S+',
        },
        action = wezterm.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          wezterm.log_info('opening: ' .. url)
          wezterm.open_with(url)
        end),
      },
    },


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

  key_tables = {
    copy_mode = copy_mode,
    search_mode = search_mode,
  },
}
