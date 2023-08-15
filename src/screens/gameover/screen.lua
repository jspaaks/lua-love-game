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

    --screen background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("GAME OVER", 0, 275, 1280, "center")
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf(State.screen:enter("playing").exit_reason, 0, 350, 1280, "center")

    -- scores
    local nhit = State.screen:enter("playing").collisions.nhit
    local nspawn = State.screen:enter("playing").balloons.nspawn
    local nbullets = State.screen:enter("playing").bullets.nremaining
    love.graphics.setFont(State.fonts["small"])
    love.graphics.print(string.format("SCORE: %d / %d", nhit, nspawn), 20, 1 * 24)
    love.graphics.print(string.format("BULLETS: %d", nbullets), 20, 2 * 24)


    -- options to continue
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO PLAY AGAIN", 0, y, 1280, "center")

    return self
end

return GameoverScreen
