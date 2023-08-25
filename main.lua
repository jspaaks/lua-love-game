--[[

set LUA_PATH to include src and lib directories, e.g. with
$ export LUA_PATH="src/?.lua;lib/?.lua;;"


And note
- that the entries are not filepaths per se, but patterns
- that Lua expands the double semicolon at the end into the default path

]]--

local status_ok, errobj = pcall(require, "mbm.mbm")
if not status_ok then
    if string.find(tostring(errobj), "module 'mbm.mbm' not found") then
        print("Game source files not found -- see instructions on how to set the path.")
    else
        print(errobj)
    end
    love.event.quit(1)
end
