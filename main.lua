require "love"
require "buttons/exit"   -- ExitButton
require "assets/ground"  -- Ground
require "assets/arrow"   -- Arrow
require "assets/arrows"  -- Arrows collection
require "assets/bow"     -- Bow
require "assets/balloon" -- Balloon

BALLOONS_PER_SECOND = 0.2
GRAVITY_ACCELERATION = 1900.0 -- pixels per s per s

function love.draw()
    State.ground:draw()
    State.exitButton:draw()
    State.bow:draw()
    State.arrows:draw()
end

function love.load()
    love.window.setTitle("The game")
    love.graphics.setBackgroundColor( 93 / 255, 173 / 255, 226 / 255, 255 / 255 )
    love.window.setMode(1640, 1280, {resizable = true, borderless = true} )
    love.window.setPosition(1730, 60)
    local _, height = love.graphics.getDimensions()
    local ground_thickness = 100
    local arrows_spawn_rate = 2.7
    local arrows_spawn_x = 80
    local arrows_spawn_y = height - ground_thickness - 10
    State = {}
    State.arrows = Arrows:new(arrows_spawn_x, arrows_spawn_y, arrows_spawn_rate)
    State.bow = Bow:new(arrows_spawn_x, arrows_spawn_y)
    State.exitButton = ExitButton:new()
    State.ground = Ground:new(ground_thickness)
    State.balloons = {}
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        local width, _ = love.graphics.getDimensions()
        local dx = (width - State.exitButton.from_right) - x
        local dy = State.exitButton.from_top - y
        local dist = dx * dx + dy * dy
        if dist <= State.exitButton.radius2 then
            love.event.quit()
        end
    end
end

function love.update(dt)
    State.arrows:update(dt)
    for _, balloon in ipairs(State.balloons) do
        balloon:update(dt)
    end
    for i, balloon in ipairs(State.balloons) do
        if not balloon.alive then
            table.remove(State.balloons, i)
        end
    end
end
