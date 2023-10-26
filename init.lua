--- Copyright (C) 2023  Jörg Bakker
---

local module = {}
module.filepath = os.getenv('HOME') .. '/.vis-mru'
module.vis_menu_path = "vis-menu"
module.vis_menu_args = "-l 10"
module.history = 20

function read_mru()
	local mru = {}
	local f = io.open(module.filepath)
	if f == nil then return end
	for line in f:lines() do
		table.insert(mru, line)
	end
	f:close()

	return mru
end

function write_mru(win)
	local file_path = win.file.path
	local mru = read_mru()
	--- Check if mru data exists
	if mru == nil then mru = {} end
	--- Check if we opened any file
	if file_path == nil then return end
	--- Check duplicates
	if file_path == mru[1] then return end
	local f = io.open(module.filepath, 'w+')
	if f == nil then return end
	table.insert(mru, 1, file_path)
	for i,k in ipairs(mru) do
		if i > module.history then break end
		if i == 1 or k ~= file_path then
			f:write(string.format('%s\n', k))
		end
	end
	f:close()
end

vis.events.subscribe(vis.events.WIN_OPEN, write_mru)

vis:command_register("mru", function(argv, force, win, selection, range)
	local command = "cat " .. module.filepath .. " | " .. module.vis_menu_path .. " " .. module.vis_menu_args .. " " .. table.concat(argv, " ")
	local status, output, stderr = vis:pipe(win.file, {start = 0, finish = 0}, command)
	if status == 0 then
		--- Remove trailing newline
		vis:command(string.format("e '%s'", output:sub(1, -2)))
	end
	vis:redraw()
	return true;
end)

return module
