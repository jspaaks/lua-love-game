local Base = require "knife.base"


---@class LevelFinishedScreen # The LevelFinishedScreen
local LevelFinishedScreen = Base:extend()


---@return LevelFinishedScreen
function LevelFinishedScreen:constructor()
    self.exit_reason = nil
    self.next_level = nil
    self.title = nil
    self.nhit = nil
    self.is_hiscore = false
    return self
end


---@return LevelFinishedScreen
function LevelFinishedScreen:update()
    if State.keypressed["q"] then
        love.event.quit(0)
    elseif State.keypressed["return"] then
        State.screen:enter("playing"):reset({
            level = self.next_level
        })
        if State.screen:enter("enter-name").needs_name then
            State.screen:change_to("enter-name")
        elseif self.is_hiscore then
            State.screen:enter("hiscores"):reset({
                score = self.nhit,
                name = State.screen:enter("enter-name").name,
                after = "playing"
            })
            State.screen:change_to("hiscores")
        else
            State.screen:change_to("playing")
        end
    end
    State.fps:update()
    return self
end


---@return LevelFinishedScreen
function LevelFinishedScreen:draw()

    --screen background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.white)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf(self.title, 0, 275, 1280, "center")
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf(self.exit_reason, 0, 350, 1280, "center")

    -- hiscore sticker
    if self.is_hiscore then
        love.graphics.push()
        love.graphics.translate(740, 260)
        love.graphics.rotate(0.1 * math.pi)
        love.graphics.setColor(State.colors["green"])
        love.graphics.rectangle("fill", 0, 0, 90, 36, 5, 5, 25)
        love.graphics.setColor(State.colors["white"])
        love.graphics.printf("HISCORE", 0, 0 - 3, 90, "center")
        love.graphics.pop()
    end

    -- legend
    State.legend:draw()

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO CONTINUE", 0, y, 1280, "center")

    -- draw fps over everything else if need be
    State.fps:draw()

    return self
end


---@return LevelFinishedScreen
function LevelFinishedScreen:reset(params)
    if params ~= nil then
        self.exit_reason = params.exit_reason or self.exit_reason
        self.next_level = params.next_level or self.next_level
        self.title = params.title or self.title
        self.nhit = params.nhit or self.nhit
        self.is_hiscore = params.is_hiscore or self.is_hiscore
    end
    return self
end

return LevelFinishedScreen
