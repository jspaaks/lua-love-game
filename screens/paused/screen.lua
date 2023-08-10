---@class PausedScreen # The PausedScreen
local PausedScreen = {
    ---@type string # class name
    __name__ = "PausedScreen",
}


---@return PausedScreen
function PausedScreen:new()
    local mt = { __index = PausedScreen }
    local members = {}
    return setmetatable(members, mt)
end


---@return PausedScreen
function PausedScreen:update()
    State.ground:update()
    State.moon:update()
    if State.keypressed["return"] then
        State.screen:change_to("playing")
    elseif State.keypressed["q"] then
        love.event.quit(0)
    end
    return self
end


---@return PausedScreen
function PausedScreen:draw()
    State.ground:draw()
    State.moon:draw()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("Paused", 1280 / 2 - 250, 300, 500, "center")
    love.graphics.setFont(State.fonts["normal"])
    love.graphics.printf("Enter to resume", 1280 / 2 - 250, 400, 500, "center")
    love.graphics.printf("Q to quit", 1280 / 2 - 250, 450, 500, "center")
    return self
end

return PausedScreen
