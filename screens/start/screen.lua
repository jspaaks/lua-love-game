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
    elseif State.keypressed["q"] then
        love.event.quit(0)
    end
    return self
end


---@return StartScreen
function StartScreen:draw()
    State.ground:draw()
    State.moon:draw()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("MIDNIGHT BALLOON MURDER", 1280 / 2 - 350, 350 - 1.5 * 64, 700, "center")
    love.graphics.setFont(State.fonts["normal"])
    love.graphics.printf("Q TO QUIT  /  ENTER TO PLAY", 0, 450, 1280, "center")
    return self
end

return StartScreen
