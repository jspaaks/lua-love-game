---@class Screens # The Screens
local Screens = {
    ---@type string # class name
    __name__ = "Screens",
    ---@type string # The current screen
    current = "start"
}


---@return Screens
function Screens:new()
    local cond = self ~= nil
    assert(cond, "Wrong signature for call to Screens:new")
    local mt = { __index = Screens }
    local members = {}
    return setmetatable(members, mt)
end

---@return Screens
function Screens:update()
    local cond = self ~= nil
    assert(cond, "Wrong signature for call to Screens:update")
    if self.current == "start" then
        if State.keypressed["return"] then
            self.current = "playing"
        end
    elseif self.current == "playing" then
        if State.keypressed["escape"] then
            self.current = "paused"
        end
    elseif self.current == "paused" then
        if State.keypressed["return"] then
            self.current = "playing"
        elseif State.keypressed["q"] then
            love.event.quit(0)
        end
    elseif self.current == "gameover" then
    end
    return self
end

return Screens
