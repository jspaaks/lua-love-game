local Base = require "knife.base"


---@class HiscoreScreen
local HiscoreScreen = Base:extend()


---@return HiscoreScreen
function HiscoreScreen:constructor()
    local emptyname = "____________"
    self.after = nil
    self.player = nil
    self.data = {
        [1] = {
            name = emptyname,
            score = nil
        },
        [2] = {
            name = emptyname,
            score = nil
        },
        [3] = {
            name = emptyname,
            score = nil
        },
        [4] = {
            name = emptyname,
            score = nil
        },
        [5] = {
            name = emptyname,
            score = nil
        },
        [6] = {
            name = emptyname,
            score = nil
        }
    }
    self.lowest = self.data[#self.data].score or 0
    self.fonts = {
        title = love.graphics.newFont("fonts/Bayon-Regular.ttf", 64),
        small = love.graphics.newFont("fonts/Bayon-Regular.ttf", 24)
    }
    return self
end


---@return HiscoreScreen
function HiscoreScreen:update()
    State.ground:update()
    State.moon:update()
    State.fps:update()
    if State.keypressed["q"] then
        love.event.quit(0)
    elseif State.keypressed["return"] then
        State.screen:change_to(self.after)
    end
    return self
end


---@return HiscoreScreen
function HiscoreScreen:draw()
    local x0 = 520            -- name column
    local x1 = 710            -- score column
    local y0 = 20             -- title
    local y1 = y0 + 230       -- column headers
    local y2 = y1 + 50        -- table rows origin
    local rowheight = 30
    local y3 = State.ground.y + State.ground.thickness * (1 / 2) - self.fonts.small:getHeight() / 2

    -- background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(self.fonts.title)
    love.graphics.print("HISCORES", x0, y0)

    -- column headers
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(self.fonts.small)
    love.graphics.print("NAME", x0, y1)
    love.graphics.print("SCORE", x1, y1)
    for irow, row in ipairs(self.data) do
        local y = y2 + rowheight * (irow - 1)
        love.graphics.print(string.format("%1d.", irow), x0 - 30, y)
        love.graphics.print(row.name, x0, y)
        love.graphics.print(tostring(row.score or ""), x1, y)
        if irow >= 6 then
            break
        end
    end

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf("Q TO QUIT  /  ENTER TO CONTINUE", 0, y3, 1280, "center")

    -- draw fps over everything else if need be
    State.fps:draw()

    return self
end


---@return HiscoreScreen
function HiscoreScreen:reset(params)
    if params ~= nil then
        self.player = params.player or self.player
        self.after = params.after or self.after
        if params.score ~= nil then
            for irow, row in ipairs(self.data) do
                if row.score ~= nil and row.score > params.score then
                    -- continue
                else
                    table.insert(self.data, irow, {
                        name = self.player,
                        score = params.score
                    })
                    table.remove(self.data, #self.data)
                    self.lowest = self.data[#self.data].score or 0
                    return self
                end
            end
        end
    end
    return self
end


return HiscoreScreen
