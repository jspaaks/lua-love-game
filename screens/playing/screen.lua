---@class PlayingScreen # The PlayingScreen
local PlayingScreen = {
    ---@type string # class name
    __name__ = "PlayingScreen",
}

---@return PlayingScreen
function PlayingScreen:new()
    local mt = { __index = PlayingScreen }
    local members = {}
    return setmetatable(members, mt)
end

---@return PlayingScreen
function PlayingScreen:update(dt)
    State.ground:update()
    State.bow:update()
    State.arrows:update(dt)
    State.balloons:update(dt)
    State.collisions:update()
    State.hit_effects:update(dt)
    State.hit_scores:update(dt)
    if State.arrows.remaining <= 0 and #State.arrows.arrows == 0 then
        State.screen:change_to("gameover")
    elseif State.keypressed["escape"] then
        State.screen:change_to("paused")
    end
    return self
end

---@return PlayingScreen
function PlayingScreen:draw()
    State.ground:draw()
    State.moon:draw()
    State.bow:draw()
    State.arrows:draw()
    State.balloons:draw()
    State.hit_effects:draw()
    State.hit_scores:draw()
    return self
end

return PlayingScreen
