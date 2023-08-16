local Bar = require "bar"


---@class Score
local Score = {
    ---@type number
    x = 60,
    ---@type number
    y = 49,
    ---@type table
    bar = {
        spacing = 5,
        width = 25,
        height = 20,
    },
    ---@type number
    nbars = 10,
    ---@type Bar[] | {}
    bars = {}
}

function Score:new()
    local mt = { __index = Score }
    local members = {}
    for i = 1, self.nbars, 1 do
        local bar = Bar:new(self.x + (i - 1) * (self.bar.spacing + self.bar.width), self.y, self.bar.width, self.bar.height)
        table.insert(self.bars, bar)
    end
    return setmetatable(members, mt)
end

function Score:update(dt)
    return self
end


function Score:draw(dt)
    local x1 = self.x
    local x0 = x1 - 8
    local x2 = x1 + self.nbars * (self.bar.spacing + self.bar.width) - self.bar.spacing
    local x3 = x2 + 8

    local y0 = 10
    local y1 = 38
    local y2 = 80

    -- hit
    local nhit = State.screen:enter("playing").collisions.nhit
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf(string.format("%d", nhit), x0 - 100, y1, 100, "right")
    love.graphics.printf("HIT", x1, y0, 100, "left")

    -- miss
    local nspawn = State.screen:enter("playing").balloons.nspawn
    local nrem = #State.screen:enter("playing").balloons.remaining
    local nelems = #State.screen:enter("playing").balloons.elements
    local nescape = nspawn - nrem - nelems - nhit
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf("MISS", x2 - 100, y0, 100, "right")
    love.graphics.printf(string.format("%d", nescape), x3, y1, 100, "left")

    -- bullets
    local nbullets = State.screen:enter("playing").bullets.nremaining
    if nbullets < 10 then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf(string.format("BULLETS"), x1, y2, (x2 - x1) * 0.55, "right")
    love.graphics.print(string.format("%d", nbullets), x1 + (x2 - x1) * 0.58, y2)

    -- bars
    local ngreen = math.floor((nhit / nspawn) * self.nbars)
    local nred = math.floor((nescape / nspawn) * self.nbars)
    for i, bar in ipairs(self.bars) do
        if i <= ngreen then
            love.graphics.setColor(0,1,0,1)
        elseif i > self.nbars - nred then
            love.graphics.setColor(1,0,0,1)
        else
            love.graphics.setColor(0.5,0.5,0.5,1)
        end
        bar:draw()
    end
    return self
end

return Score
