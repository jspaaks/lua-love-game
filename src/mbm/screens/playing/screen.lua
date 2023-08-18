local Base = require "knife.base"
local Bullets = require "mbm.screens.playing.bullets"
local Balloons = require "mbm.screens.playing.balloons"
local Turret = require "mbm.screens.playing.turret"
local Collisions = require "mbm.screens.playing.collisions"

---@class PlayingScreen # The PlayingScreen
local PlayingScreen = Base:extend()


---@return PlayingScreen
---@param ground Ground # reference to the Ground object
function PlayingScreen:constructor(ground, level)
    local balloons_spawn_rate = 0.5
    local nspawn = 10
    local nbullets = 100
    self.ground = ground
    self.turret = Turret(ground)
    self.bullets = Bullets(self.turret, nbullets)
    self.balloons = Balloons(balloons_spawn_rate, ground, nspawn)
    self.collisions = Collisions(self.bullets, self.balloons)
    self.level = level or "novice"
    self.levels = {
        novice = {
            nalotted = 100,
            nspawn = 10,
            next = "private"
        },
        private = {
            nalotted = 70,
            nspawn = 20,
            next = "gunny"
        },
        gunny = {
            nalotted = 40,
            nspawn = 40,
            next = "sharpshooter"
        },
        sharpshooter = {
            nalotted = 20,
            nspawn = 70,
            next = "assassin"
        },
        assassin = {
            nalotted = 10,
            nspawn = 100,
            next = "berserker"
        },
        berserker = {
            nalotted = 10,
            nspawn = 1000,
            next = "berserker"
        }
    }
    return self
end

---@return PlayingScreen
function PlayingScreen:update(dt)
    State.ground:update()
    self.turret:update(dt)
    self.bullets:update(dt)
    self.balloons:update(dt)
    self.collisions:update(dt)
    State.legend:update(dt)
    State.level_indicator:update()
    State.fps:update()

    local out_of_bullets = self.bullets.nremaining <= 0 and #self.bullets.elements == 0
    local no_more_balloons = #self.balloons.remaining <= 0 and #self.balloons.elements <= 0
    if out_of_bullets or no_more_balloons then
        local title = nil
        local next_level = nil
        local nhit = self.collisions.nhit
        local nspawn = self.balloons.nspawn
        if nhit == nspawn then
            title = "PERFECT SCORE!"
            next_level = self.levels[self.level].next
        elseif nhit / nspawn >= 0.9 then
            title = "GREAT JOB!"
            next_level = self.levels[self.level].next
        elseif nhit / nspawn >= 0.8 then
            title = "GOOD JOB!"
            next_level = self.levels[self.level].next
        else
            title = "TRY AGAIN"
            next_level = self.level
        end
        self.balloons.elements = {}
        self.balloons.remaining = {}
        State.screen:enter("levelfinished"):reset({
            ["exit_reason"] = #self.balloons.remaining > 0 and "Out of bullets" or "No more balloons",
            ["title"] = title,
            ["next_level"] = next_level
        })
        State.screen:change_to("levelfinished")
    elseif State.keypressed["escape"] then
        State.screen:change_to("paused")
    end
    return self
end

---@return PlayingScreen
function PlayingScreen:draw()

    -- balloons and level indicator
    State.level_indicator:draw()

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

    -- draw fps over everything else if need be
    State.fps:draw()

    return self
end

function PlayingScreen:reset(params)
    if params ~= nil then
        self.level = params.level or self.level
    end
    self.balloons:reset({nspawn = self.levels[self.level].nspawn})
    self.bullets:reset({nalotted = self.levels[self.level].nalotted})
    self.collisions:reset()
    self.turret:reset()
    State.level_indicator:reset({
        level = self.level,
        nballoons = #self.balloons.elements + #self.balloons.remaining
    })
end

return PlayingScreen
