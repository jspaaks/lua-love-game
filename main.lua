require "love"
require "screens"
require "screens/playing/moon"
require "screens/playing/ground"
require "screens/playing/arrow"
require "screens/playing/arrows"
require "screens/playing/bow"
require "screens/playing/balloon"
require "screens/playing/balloons"
require "screens/playing/hits"
require "screens/playing/hit"


GRAVITY_ACCELERATION = 1900.0 -- pixels per s per s

function love.load()
    math.randomseed(os.time())
    love.window.setTitle("Midnight Balloon Murder")
    love.graphics.setBackgroundColor( 0 / 255, 22 / 255, 43 / 255, 255 / 255 )
    love.window.setMode(1280, 720, {resizable = false, borderless = false} )
    local balloons_spawn_rate = 0.5
    local ground_thickness = 100
    local arrows_spawn_dx = 80
    local arrows_spawn_dy = -50
    State = {}
    State.sounds = {
        ["shot"] = love.audio.newSource("sounds/shot.wav", "static"),
        ["pop"] = love.audio.newSource("sounds/pop.wav", "static")
    }
    State.fonts = {
        ["title"] = love.graphics.newFont("fonts/Bayon-Regular.ttf", 64),
        ["normal"] = love.graphics.newFont("fonts/Bayon-Regular.ttf", 32)
    }
    State.keypressed = {}
    State.screens = Screens:new()
    State.moon = Moon:new()
    State.ground = Ground:new(ground_thickness)
    State.bow = Bow:new(arrows_spawn_dx, arrows_spawn_dy, State.ground)
    State.arrows = Arrows:new(State.bow)
    State.balloons = Balloons:new(balloons_spawn_rate, State.ground)
    State.hits = Hits:new(State.arrows, State.balloons)
end

function love.update(dt)
    State.screens:update()
    if State.screens.current == "playing" then
        State.ground:update()
        State.bow:update()
        State.arrows:update(dt)
        State.balloons:update(dt)
        State.hits:update(dt)
    end
    State.keypressed = {}
end

function love.draw()
    if State.screens.current == "playing" then
        State.ground:draw()
        State.moon:draw()
        State.bow:draw()
        State.arrows:draw()
        State.balloons:draw()
        State.hits:draw()
    elseif State.screens.current == "start" then
        love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
        love.graphics.setFont(State.fonts["title"])
        love.graphics.printf("Midnight Balloon Murder", 1280 / 2 - 350, 350 - 1.5 * 64, 700, "center")
        love.graphics.setFont(State.fonts["normal"])
        love.graphics.printf("Press Enter to start the game", 1280 / 2 - 250, 500, 500, "center")
    elseif State.screens.current == "paused" then
        love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
        love.graphics.setFont(State.fonts["title"])
        love.graphics.printf("Paused", 1280 / 2 - 250, 300, 500, "center")
        love.graphics.setFont(State.fonts["normal"])
        love.graphics.printf("Enter to resume", 1280 / 2 - 250, 400, 500, "center")
        love.graphics.printf("Q to quit", 1280 / 2 - 250, 450, 500, "center")
    elseif State.screens.current == "gameover" then
        love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
        love.graphics.setFont(State.fonts["title"])
        love.graphics.printf("Game over", 1280 / 2 - 250, 350, 500, "center")
    end
end

function love.keypressed(key, scancode, isrepeat)
    State.keypressed[key] = true
end

function love.resize(w, h)
    State.arrows:remove_all()
    State.balloons:remove_all()
    State.hits:remove_all()
end
