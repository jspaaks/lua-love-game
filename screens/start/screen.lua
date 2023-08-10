---@class StartScreen # The StartScreen
local StartScreen = {
    ---@type string # class name
    __name__ = "StartScreen",
}


---@return StartScreen
function StartScreen:new()
    local mt = { __index = StartScreen }
    local members = {}
    return setmetatable(members, mt)
end


---@return StartScreen
function StartScreen:update()
    State.ground:update()
    State.moon:update()
    if State.keypressed["return"] then
        State.screen:change_to("playing")
    end
    return self
end


---@return StartScreen
function StartScreen:draw()
    State.ground:draw()
    State.moon:draw()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("Midnight Balloon Murder", 1280 / 2 - 350, 350 - 1.5 * 64, 700, "center")
    love.graphics.setFont(State.fonts["normal"])
    love.graphics.printf("Press Enter to start the game", 1280 / 2 - 250, 500, 500, "center")
    return self
end

return StartScreen
