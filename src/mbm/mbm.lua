require "love"
local Fsm = require "mbm.shared.fsm"
local Ground = require "mbm.shared.ground"
local Moon = require "mbm.shared.moon"
local StartScreen = require "mbm.screens.start.screen"
local PlayingScreen = require "mbm.screens.playing.screen"
local PausedScreen = require "mbm.screens.paused.screen"
local LevelFinishedScreen = require "mbm.screens.level-finished.screen"
local Legend = require "mbm.shared.legend"
local LevelIndicator = require "mbm.shared.level-indicator"
local Fps = require "mbm.shared.fps"


State = {}


function love.load()
    math.randomseed(os.time())
    love.window.setTitle("Midnight Balloon Murder")
    love.graphics.setBackgroundColor( 0 / 255, 22 / 255, 43 / 255, 255 / 255 )
    love.window.setMode(1280, 720, {resizable = false, borderless = false} )
    local ground_thickness = 100
    State.GRAVITY_ACCELERATION = 1900.0 -- pixels per s per s
    State.fonts = {
        title = love.graphics.newFont("fonts/Bayon-Regular.ttf", 64),
        normal = love.graphics.newFont("fonts/Bayon-Regular.ttf", 32),
        small = love.graphics.newFont("fonts/Bayon-Regular.ttf", 24)
    }
    State.keypressed = {}
    State.fps = Fps()
    State.colors = {
        ["magenta"] = {200 / 255, 0, 161 / 255, 1},
        ["red"] = {200 / 255, 0, 0, 1},
        ["orange"] = {200 / 255, 161 / 255, 0, 1},
        ["green"] = {0, 161 / 255, 0, 1},
        ["lightgray"] = {0.9, 0.9, 0.9, 1},
        ["middlegray"] = {0.5, 0.5, 0.5, 1},
        ["white"] = {1, 1, 1, 1}
    }
    State.moon = Moon()
    State.ground = Ground(ground_thickness)
    State.level_indicator = LevelIndicator()
    State.screen = Fsm({
        {
            name = "start",
            state = StartScreen()
        },
        {
            name = "playing",
            state = PlayingScreen(State.ground)
        },
        {
            name = "paused",
            state = PausedScreen()
        },
        {
            name = "levelfinished",
            state = LevelFinishedScreen()
        },
    })
    State.legend = Legend()
end

function love.update(dt)
    State.screen:update(dt)
    State.keypressed = {}
end

function love.draw()
    State.screen:draw()
end

function love.keypressed(key, scancode, isrepeat)
    State.keypressed[key] = true
end

function love.resize(w, h)
    State.arrows:mark_all_as_dead()
    State.balloons:mark_all_as_dead()
    State.hit_effects:mark_all_as_dead()
end
