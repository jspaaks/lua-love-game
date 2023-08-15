local Bullets = require "screens.playing.bullets"
local Balloons = require "screens.playing.balloons"
local Turret = require "screens.playing.turret"
local Collisions = require "screens.playing.collisions"


---@class PlayingScreen # The PlayingScreen
local PlayingScreen = {
    ---@type string # class name
    __name__ = "PlayingScreen",
    ---@type Bullets # Reference to the Bullets collection
    bullets = nil,
    ---@type Balloons # Reference to the Balloons collection
    balloons = nil,
    ---@type string # Reason for gameover
    exit_reason = nil,
    ---@type Turret # Reference to the Turret object
    turret = nil,
    ---@type Collisions # Reference to the Collisions collection
    collisions = nil,
    ---@type Ground # Reference to the Ground object
    ground = nil,
}

---@return PlayingScreen
---@param ground Ground # reference to the Ground object
function PlayingScreen:new(ground)
    local mt = { __index = PlayingScreen }
    local balloons_spawn_rate = 0.5
    local turret = Turret:new(ground)
    local bullets = Bullets:new(turret)
    local balloons = Balloons:new(balloons_spawn_rate, ground)
    local members = {
        bullets = bullets,
        balloons = balloons,
        turret = turret,
        collisions = Collisions:new(bullets, balloons),
        ground = ground
    }
    return setmetatable(members, mt)
end

---@return PlayingScreen
function PlayingScreen:update(dt)
    State.ground:update()
    self.turret:update(dt)
    self.bullets:update(dt)
    self.balloons:update(dt)
    self.collisions:update(dt)
    local no_more_balloons = #self.balloons.remaining == 0 and #self.balloons.elements == 0
    local no_more_bullets = self.bullets.nremaining <= 0 and #self.bullets.elements == 0
    if no_more_bullets then
        self.exit_reason = "Out of bullets"
        State.screen:change_to("gameover")
    elseif no_more_balloons then
        self.exit_reason = "No more balloons"
        State.screen:change_to("gameover")
    elseif State.keypressed["escape"] then
        State.screen:change_to("paused")
    end
    return self
end

---@return PlayingScreen
function PlayingScreen:draw()
    State.moon:draw()
    self.bullets:draw()
    self.balloons:draw()
    State.ground:draw()
    self.turret:draw()
    self.collisions:draw()
    love.graphics.setColor(0.9, 0.9, 0.9, 0.9)
    love.graphics.setFont(State.fonts["small"])
    local y0 = self.ground.y + self.ground.thickness * (1 / 3) - State.fonts.small:getHeight() / 2
    local y1 = self.ground.y + self.ground.thickness * (2 / 3) - State.fonts.small:getHeight() / 2
    love.graphics.printf("W: TURRET UP", 0, y0, 1280 / 2, "center")
    love.graphics.printf("S: TURRENT DOWN", 0, y1, 1280 / 2, "center")
    love.graphics.printf("ESC: PAUSE", 1280 / 2, y0, 1280 / 2, "center")
    love.graphics.printf("SPACE: SHOOT", 1280 / 2, y1, 1280 / 2, "center")
    local nhit = State.screen:enter("playing").collisions.nhit
    local nspawn = State.screen:enter("playing").balloons.nspawn
    local nbullets = State.screen:enter("playing").bullets.nremaining
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(string.format("SCORE: %d / %d", nhit, nspawn), 20, 1 * 24)
    love.graphics.print(string.format("BULLETS: %d", nbullets), 20, 2 * 24)
    return self
end

function PlayingScreen:reset()
    self.balloons:reset()
    self.bullets:reset()
    self.collisions:reset()
end

return PlayingScreen
