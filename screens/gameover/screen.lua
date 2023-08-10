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
        State:reset()
    end
    return self
end


---@return GameoverScreen
function GameoverScreen:draw()
    State.ground:draw()
    State.moon:draw()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("Game over", 1280 / 2 - 250, 275, 500, "center")
    love.graphics.setFont(State.fonts["normal"])
    love.graphics.printf(string.format("Score: %d", State.collisions.cvalue), 0, 400, 1280, "center")
    love.graphics.printf("Q to quit  /  Enter to play again", 0, 450, 1280, "center")
    return self
end

return GameoverScreen
