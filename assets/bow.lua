---@class Bow # The Bow.
Bow = {
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil
}

---@return Bow
function Bow:new(x, y)
    assert(self ~= nil, "Wrong signature for call to Bow:new")
    local mt = { __index = Bow }
    local members = {
        x = x,
        y = y
    }
    return setmetatable(members, mt)
end

function Bow:draw()
    assert(self ~= nil, "Wrong signature for call to Bow:draw")
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.circle("fill", self.x, self.y, 4)
end
