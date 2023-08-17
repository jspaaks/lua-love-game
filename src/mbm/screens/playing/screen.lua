local Base = require "knife.base"
local Bullets = require "mbm.screens.playing.bullets"
local Balloons = require "mbm.screens.playing.balloons"
local Turret = require "mbm.screens.playing.turret"
local Collisions = require "mbm.screens.playing.collisions"


---@class PlayingScreen # The PlayingScreen
local PlayingScreen = Base:extend()


---@return PlayingScreen
---@param ground Ground # reference to the Ground object
function PlayingScreen:constructor(ground)
    local balloons_spawn_rate = 0.5
    local nspawn = 100
    self.ground = ground
    self.turret = Turret(ground)
    self.bullets = Bullets:new(self.turret)
    self.balloons = Balloons(balloons_spawn_rate, ground, nspawn)
    self.collisions = Collisions:new(self.bullets, self.balloons)
    self.exit_reason = nil
    return self
end

---@return PlayingScreen
function PlayingScreen:update(dt)
    State.ground:update()
    State.legend:update(dt)
    self.turret:update(dt)
    self.bullets:update(dt)
    self.balloons:update(dt)
    self.collisions:update(dt)
    local no_more_balloons = #self.balloons.remaining == 0 and #self.balloons.elements == 0
    local no_more_bullets = self.bullets.nremaining <= 0 and #self.bullets.elements == 0
    if no_more_balloons then
        self.exit_reason = "No more balloons"
        if self.collisions.nhit == self.balloons.nspawn then
            State.screen:change_to("perfectscore")
        else
            State.screen:change_to("gameover")
        end
    elseif no_more_bullets then
        self.exit_reason = "Out of bullets"
        State.screen:change_to("gameover")
    elseif State.keypressed["escape"] then
        State.screen:change_to("paused")
    end
    return self
end

---@return PlayingScreen
function PlayingScreen:draw()

    -- screen elements
    State.moon:draw()
    self.bullets:draw()
    self.balloons:draw()
    State.ground:draw()
    self.turret:draw()
    self.collisions:draw()

    -- legend
    State.legend:draw()

    -- key hints
    local y0 = self.ground.y + self.ground.thickness * (1 / 3) - State.fonts.small:getHeight() / 2
    local y1 = self.ground.y + self.ground.thickness * (2 / 3) - State.fonts.small:getHeight() / 2
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf("W: TURRET UP", 0, y0, 1280 / 2, "center")
    love.graphics.printf("S: TURRENT DOWN", 0, y1, 1280 / 2, "center")
    love.graphics.printf("ESC: PAUSE", 1280 / 2, y0, 1280 / 2, "center")
    love.graphics.printf("SPACE: SHOOT", 1280 / 2, y1, 1280 / 2, "center")
    return self
end

function PlayingScreen:reset()
    self.balloons:reset()
    self.bullets:reset()
    self.collisions:reset()
    self.turret:reset()
end

return PlayingScreen
