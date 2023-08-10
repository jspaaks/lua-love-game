---@class GameoverScreen # The GameoverScreen
local GameoverScreen = {
    ---@type string # class name
    __name__ = "GameoverScreen",
}


---@return GameoverScreen
function GameoverScreen:new()
    local mt = { __index = GameoverScreen }
    local members = {}
    return setmetatable(members, mt)
end


---@return GameoverScreen
function GameoverScreen:update()
    if State.keypressed["q"] then
        love.event.quit(0)
    elseif State.keypressed["return"] then
        State.screen:enter("playing"):reset()
        State.screen:change_to("playing")
    end
    return self
end


---@return GameoverScreen
function GameoverScreen:draw()
    State.ground:draw()
    State.moon:draw()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("GAME OVER", 1280 / 2 - 250, 275, 500, "center")
    love.graphics.setFont(State.fonts["normal"])
    local score = State.screen:enter("playing").collisions.cvalue
    love.graphics.printf(string.format("SCORE: %d", score), 0, 400, 1280, "center")
    love.graphics.printf("Q TO QUIT  /  ENTER TO PLAY AGAIN", 0, 450, 1280, "center")
    return self
end

return GameoverScreen
