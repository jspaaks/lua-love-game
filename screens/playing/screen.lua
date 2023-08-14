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
    local bullets_spawn_x = 80
    local bullets_spawn_dy = -50
    local balloons_spawn_rate = 0.5
    local turret = Turret:new(bullets_spawn_x, bullets_spawn_dy, ground)
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
    self.turret:update()
    self.bullets:update(dt)
    self.balloons:update(dt)
    self.collisions:update(dt)
    local no_more_balloons = #self.balloons.remaining == 0 and #self.balloons.elements == 0
    local no_more_bullets = self.bullets.nremaining <= 0 and #self.bullets.elements == 0
    if no_more_bullets or no_more_balloons then
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
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(State.fonts["small"])
    local y = self.ground.y + self.ground.thickness / 2 - State.fonts.small:getHeight() / 2
    love.graphics.printf("ESC TO PAUSE  /  SPACE TO SHOOT", 0, y, 1280, "center")
    local nhit = State.screen:enter("playing").collisions.nhit
    local nspawn = State.screen:enter("playing").balloons.nspawn
    local nbullets = State.screen:enter("playing").bullets.nremaining
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
