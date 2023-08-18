local Base = require "knife.base"

local Fps = Base:extend()


function Fps:constructor()
    self.fps = false
end


function Fps:draw()
    if self.showfps then
        love.graphics.setFont(State.fonts.small)
        love.graphics.setColor(1, 1, 0, 1)
        local fps = string.format("FPS: %d", love.timer.getFPS())
        love.graphics.print(fps, 120, 10)
    end
end


function Fps:update()
    if State.keypressed["f"] then
        self.showfps = not self.showfps
    end
end

return Fps
