local Arrows = require "screens.playing.arrows"
local Balloons = require "screens.playing.balloons"
local Bow = require "screens.playing.bow"
local Collisions = require "screens.playing.collisions"


---@class PlayingScreen # The PlayingScreen
local PlayingScreen = {
    ---@type string # class name
    __name__ = "PlayingScreen",
    ---@type Arrows # Reference to the Arrows collection
    arrows = nil,
    ---@type Balloons # Reference to the Balloons collection
    balloons = nil,
    ---@type Bow # Reference to the Bow object
    bow = nil,
    ---@type Collisions # Reference to the Collisions collection
    collisions = nil,
    ---@type Ground # Reference to the Ground object
    ground = nil,
}

---@return PlayingScreen
---@param ground Ground # reference to the Ground object
function PlayingScreen:new(ground)
    local mt = { __index = PlayingScreen }
    local arrows_spawn_x = 80
    local arrows_spawn_dy = -50
    local balloons_spawn_rate = 0.5
    local bow = Bow:new(arrows_spawn_x, arrows_spawn_dy, ground)
    local arrows = Arrows:new(bow)
    local balloons = Balloons:new(balloons_spawn_rate, ground)
    local members = {
        arrows = arrows,
        balloons = balloons,
        bow = bow,
        collisions = Collisions:new(arrows, balloons),
        ground = ground
    }
    return setmetatable(members, mt)
end

---@return PlayingScreen
function PlayingScreen:update(dt)
    State.ground:update()
    self.bow:update()
    self.arrows:update(dt)
    self.balloons:update(dt)
    self.collisions:update(dt)
    local no_more_balloons = #self.balloons.remaining == 0 and #self.balloons.balloons == 0
    local no_more_arrows = self.arrows.remaining <= 0 and #self.arrows.arrows == 0
    if no_more_arrows or no_more_balloons then
        State.screen:change_to("gameover")
    elseif State.keypressed["escape"] then
        State.screen:change_to("paused")
    end
    return self
end

---@return PlayingScreen
function PlayingScreen:draw()
    State.moon:draw()
    self.arrows:draw()
    self.balloons:draw()
    State.ground:draw()
    self.bow:draw()
    self.collisions:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(State.fonts["small"])
    local y = self.ground.y + self.ground.thickness / 2 - State.fonts.small:getHeight() / 2
    love.graphics.printf("ESC TO PAUSE  /  SPACE TO SHOOT", 0, y, 1280, "center")
    local score = string.format("SCORE: %d", self.arrows.remaining + self.collisions.cvalue)
    local remaining = string.format("BULLETS: %d", self.arrows.remaining)
    love.graphics.print(score, 20, 1 * 24)
    love.graphics.print(remaining, 20, 2 * 24)
    return self
end

function PlayingScreen:reset()
    self.balloons:reset()
    self.arrows:reset()
    self.collisions:reset()
end

return PlayingScreen
