--[[

set LUA_PATH to include src and lib directories, e.g. with
$ export LUA_PATH="src/?.lua;lib/?.lua;;"


And note
- that the entries are not filepaths per se, but patterns
- that Lua expands the double semicolon at the end into the default path

]]--

if pcall(require, "mbm.mbm") then
    -- pass
else
    print("Game source files not found -- see instructions on how to set the path.")
    love.event.quit(1)
end
