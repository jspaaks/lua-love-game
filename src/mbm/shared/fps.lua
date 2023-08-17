local Base = require "knife.base"

local Fps = Base:extend()


function Fps:constructor()
end


function Fps:draw()
    if State.showfps then
        love.graphics.setFont(State.fonts.small)
        love.graphics.setColor(1, 1, 0, 1)
        local fps = string.format("FPS: %d", love.timer.getFPS())
        love.graphics.print(fps, 120, 10)
    end
end


function Fps:update()
    if State.keypressed["f"] then
        State.showfps = not State.showfps
    end
end

return Fps
