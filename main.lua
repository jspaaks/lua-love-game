require "love"
local Fsm = require "fsm"
local Ground = require "ground"
local Moon = require "moon"
local StartScreen = require "screens.start.screen"
local PlayingScreen = require "screens.playing.screen"
local PausedScreen = require "screens.paused.screen"
local GameoverScreen = require "screens.gameover.screen"
local Score = require "score"

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
    State.showfps = false
    State.moon = Moon:new()
    State.ground = Ground:new(ground_thickness)
    State.screen = Fsm:create({
        {
            name = "start",
            state = StartScreen:new()
        },
        {
            name = "playing",
            state = PlayingScreen:new(State.ground)
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
    State.score = Score:new()
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
        love.graphics.print(fps, 20, 3 * 24)
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
