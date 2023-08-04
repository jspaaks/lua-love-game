require "love"
require "buttons/exit"   -- ExitButton
require "assets/ground"  -- Ground
require "assets/arrow"   -- Arrow
require "assets/bow"     -- Bow
require "assets/balloon" -- Balloon

ARROWS_PER_SECOND = 0.2
BALLOONS_PER_SECOND = 0.1

function love.load()
    love.window.setTitle("The game")
    love.graphics.setBackgroundColor( 93 / 255, 173 / 255, 226 / 255, 255 / 255 )
    love.window.setMode(1640, 1280, {resizable = true, borderless = true} )
    love.window.setPosition(1730, 60)
    State = {}
    State.exitButton = ExitButton:new()
    State.ground = Ground:new(100)
    State.bow = Bow:new(80, State.ground.y - 10 )
    State.arrows = {}
    State.balloons = {}
end

function love.update(dt)
    if math.random() < ARROWS_PER_SECOND * dt then
        local arrow = Arrow:new(20, -30, State.bow.x, State.bow.y)
        table.insert(State.arrows, arrow)
    end
    for _, arrow in ipairs(State.arrows) do
        arrow:update(dt)
    end
    for i, arrow in ipairs(State.arrows) do
        if not arrow.alive then
            table.remove(State.arrows, i)
        end
    end
    for _, balloon in ipairs(State.balloons) do
        balloon:update(dt)
    end
    for i, balloon in ipairs(State.balloons) do
        if not balloon.alive then
            table.remove(State.balloons, i)
        end
    end
end

function love.draw()
    State.ground:draw()
    State.exitButton:draw()
    State.bow:draw()
    for _, arrow in ipairs(State.arrows) do
        arrow:draw()
    end
end
