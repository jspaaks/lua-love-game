require "love"
local Fsm = require "fsm"
local Arrows = require "screens.playing.arrows"
local Balloons = require "screens.playing.balloons"
local Bow = require "screens.playing.bow"
local Collisions = require "screens.playing.collisions"
local Ground = require "ground"
local HitEffects = require "screens.playing.hit-effects"
local HitScores = require "screens.playing.hit-scores"
local Moon = require "moon"
local StartScreen = require "screens.start.screen"
local PlayingScreen = require "screens.playing.screen"
local PausedScreen = require "screens.paused.screen"
local GameoverScreen = require "screens.gameover.screen"


State = {}

function State:reset()
    State.balloons.balloons = {}
    State.arrows.arrows = {}
    State.arrows.remaining = State.arrows.alotted
    State.hit_effects.hit_effects = {}
    State.hit_scores.hit_scores = {}
    State.collisions.cvalue = 0
    State.screen:change_to("playing")
end

function love.load()
    math.randomseed(os.time())
    love.window.setTitle("Midnight Balloon Murder")
    love.graphics.setBackgroundColor( 0 / 255, 22 / 255, 43 / 255, 255 / 255 )
    love.window.setMode(1280, 720, {resizable = false, borderless = false} )
    local balloons_spawn_rate = 0.5
    local ground_thickness = 100
    local arrows_spawn_dx = 80
    local arrows_spawn_dy = -50
    State.GRAVITY_ACCELERATION = 1900.0 -- pixels per s per s
    State.fonts = {
        title = love.graphics.newFont("fonts/Bayon-Regular.ttf", 64),
        normal = love.graphics.newFont("fonts/Bayon-Regular.ttf", 32),
        small = love.graphics.newFont("fonts/Bayon-Regular.ttf", 24)
    }
    State.keypressed = {}
    State.showfps = false
    State.moon = Moon:new()
    State.ground = Ground:new(ground_thickness)
    State.bow = Bow:new(arrows_spawn_dx, arrows_spawn_dy, State.ground)
    State.arrows = Arrows:new(State.bow)
    State.balloons = Balloons:new(balloons_spawn_rate, State.ground)
    State.collisions = Collisions:new(State.arrows, State.balloons)
    State.hit_effects = HitEffects:new()
    State.hit_scores = HitScores:new()
    State.screen = Fsm:create({
        {
            name = "start",
            state = StartScreen:new()
        },
        {
            name = "playing",
            state = PlayingScreen:new()
        },
        {
            name = "paused",
            state = PausedScreen:new()
        },
        {
            name = "gameover",
            state = GameoverScreen:new()
        }
    })
end

function love.update(dt)
    State.screen:update(dt)
    if State.keypressed["f"] then
        State.showfps = not State.showfps
    end
    State.keypressed = {}
end

function love.draw()
    State.screen:draw()
    if State.showfps then
        love.graphics.setFont(State.fonts.small)
        love.graphics.setColor(1, 1, 0, 1)
        local fps = string.format("FPS: %d", love.timer.getFPS())
        love.graphics.print(fps, 20, 20)
    end
end

function love.keypressed(key, scancode, isrepeat)
    State.keypressed[key] = true
end

function love.resize(w, h)
    State.arrows:mark_all_as_dead()
    State.balloons:mark_all_as_dead()
    State.hit_effects:mark_all_as_dead()
end
