---@class Bar
local Bar = {
    ---@type number
    x = nil,
    ---@type number
    y = nil,
    ---@type number
    w = nil,
    ---@type number
    h = nil
}

function Bar:new(x, y, w, h)
    local mt = { __index = Bar }
    local members = {
        x = x,
        y = y,
        w = w,
        h = h
    }
    return setmetatable(members, mt)
end


function Bar:update(dt)
end


function Bar:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end


return Bar
