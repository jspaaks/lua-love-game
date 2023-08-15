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
    love.graphics.printf("PAUSED", 0, 275, 1280, "center")
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO RESUME", 0, y, 1280, "center")
    local nhit = State.screen:enter("playing").collisions.nhit
    local nspawn = State.screen:enter("playing").balloons.nspawn
    local nbullets = State.screen:enter("playing").bullets.nremaining
    love.graphics.print(string.format("SCORE: %d / %d", nhit, nspawn), 20, 1 * 24)
    love.graphics.print(string.format("BULLETS: %d", nbullets), 20, 2 * 24)
    return self
end

return PausedScreen
