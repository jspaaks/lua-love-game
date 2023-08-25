local Base = require "knife.base"
local clip = require "mbm.shared.clip"


---@class EnterNameScreen # The EnterNameScreen
local EnterNameScreen = Base:extend()


---@return EnterNameScreen
function EnterNameScreen:constructor()
    self.needs_name = true
    self.emptyname = "            "
    self.name = self.emptyname
    self.maxlen = string.len(self.emptyname)
    self.pos = 1
    self.sounds = {
        click = love.audio.newSource("sounds/click.wav", "static"),
        denied = love.audio.newSource("sounds/denied.wav", "static")
    }
    return self
end


---@return EnterNameScreen
function EnterNameScreen:update()
    local keys = {
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
        "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "space"
    }
    for i = 1, #keys do
        local key = keys[i]
        if State.keypressed[key] then
            local c = key == "space" and " " or key
            if self.pos <= self.maxlen then
                self.name = string.sub(self.name, 1, self.pos - 1) .. c .. string.sub(self.name, self.pos + 1)
                self.pos = self.pos + 1
                self.sounds.click:clone():play()
            else
                self.sounds.denied:clone():play()
            end
        end
    end
    if State.keypressed["backspace"] then
        if self.pos > 1 then
            self.pos = math.max(self.pos - 1, 1)
            self.name = string.sub(self.name, 1, self.pos - 1) .. string.sub(self.name, self.pos + 1)
            self.sounds.click:clone():play()
        else
            self.sounds.denied:clone():play()
        end
    elseif State.keypressed["return"] then
        self.needs_name = false
        State.screen:enter("hiscores"):reset({
            player = self.name == self.emptyname and "PLAYER" or self.name,
            score = State.screen:enter("level-finished").nhit,
            after = "playing"
        })
        State.screen:change_to("hiscores")
    end
    return self
end


---@return EnterNameScreen
function EnterNameScreen:draw()

    --screen background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.white)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("ENTER NAME", 0, 20, 1280, "center")

    -- lines under name letters
    love.graphics.setFont(State.fonts["small"])
    local x0 = 490 - 3
    local y0 = 360
    local y1 = y0 + 40
    local w = 20
    local h = 3
    local spacing = 6
    for i = 1, self.maxlen do
        local x1 = x0 + (i - 1) * (w + spacing)
        love.graphics.printf(string.sub(self.name, i, i), x1, y0, w, "center")
        love.graphics.rectangle("fill", x1, y1, w, h, h / 2, h / 2, 15)
    end

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("ENTER TO CONTINUE", 0, y, 1280, "center")

    return self
end


---@return EnterNameScreen
function EnterNameScreen:reset(params)
    if params ~= nil then
        self.name = params.name or self.name
    end
    return self
end

return EnterNameScreen
