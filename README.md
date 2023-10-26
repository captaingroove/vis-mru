# Menu for most recently used files in vis

Use vis-menu to open most recently used files in [vis](https://github.com/martanne/vis).

## Usage

In vis:

`:mru`

## Configuration

In visrc.lua:

```lua
plugin_vis_mru = require('plugins/vis-mru')

-- Path to the vis-menu executable (default: "vis-menu")
plugin_vis_mru.vis_menu_path = "vis-menu"

-- Arguments passed to vis-menu (default: "-l 10")
plugin_vis_mru.vis_menu_args = "-l 10"

-- File path to file history (default: "$HOME/.mru") 
plugin_vis_mru.filepath = os.getenv("HOME") .. "/.vis-mru"

-- The number of most recently used files kept in history (default: 20)
plugin_vis_mru.history = 60

-- Mapping configuration example (<Space>f)
vis.events.subscribe(vis.events.INIT, function()
    vis:map(vis.modes.NORMAL, " f", ":mru<Enter>", "most recent files")
end)
```

## Inspired by

- [vis-fzf-mru](https://github.com/peaceant/vis-fzf-mru.git)
