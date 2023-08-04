require "love"
require "exit-button"

function love.load()
    love.window.setTitle("The game")
    love.window.setMode(0, 0, {resizable = true, borderless = true} )
    State = {}
    State.exitButton = ExitButton:new()
end

function love.update()
end

function love.draw()
    State.exitButton:draw()
end
