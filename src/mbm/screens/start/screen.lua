local Base = require "knife.base"


---@class StartScreen
local StartScreen = Base:extend()


---@return StartScreen
function StartScreen:constructor()
    self.fonts = {
        small = love.graphics.newFont("fonts/Bayon-Regular.ttf", 70),
        big = love.graphics.newFont("fonts/Bayon-Regular.ttf", 80)
    }
    self.y0 = 300           -- top line
    self.y1 = self.y0 - 36  -- big font
    self.y2 = self.y0 - 31  -- small font
    self.y3 = self.y0 + 62  -- bottom line
    return self
end


---@return StartScreen
function StartScreen:update()
    State.ground:update()
    State.moon:update()
    State.fps:update()
    if State.keypressed["return"] then
        State.screen:enter("playing"):reset({level = "novice"})
        State.screen:change_to("playing")
    elseif State.keypressed["q"] then
        love.event.quit(0)
    elseif State.keypressed["h"] then
        State.screen:enter("hiscores"):reset({
            after = "start"
        })
        State.screen:change_to("hiscores")
    end
    return self
end


---@return StartScreen
function StartScreen:draw()
    -- background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setLineWidth(2)
    love.graphics.line(298, self.y0, 975, self.y0)
    love.graphics.line(341, self.y3, 938, self.y3)
    love.graphics.setFont(self.fonts.big)
    love.graphics.print("M", 295, self.y1)
    love.graphics.print("R", 940, self.y1)
    love.graphics.setFont(self.fonts.small)
    love.graphics.printf("IDNIGHT BALLOON MURDE", 0, self.y2, 1280, "center")

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO PLAY", 0, y, 1280, "center")

    -- draw fps over everything else if need be
    State.fps:draw()

    return self
end


---@return StartScreen
function StartScreen:reset()
    return self
end

return StartScreen
