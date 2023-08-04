---@class Vector # 2-D vector.
Vector = {
    ---@type number | nil # Length of the vector in the first dimension.
    x = nil,
    ---@type number | nil # Length of the vector in the second dimension.
    y = nil
}


---@param x number # Length of the vector in the first dimension.
---@param y number # Length of the vector in the second dimension.
---@return Vector # New instance of Vector.
function Vector:new(x, y)
    assert(self ~= nil and type(x) == "number" and type(y) == "number", "Wrong signature for call to Vector:new")
    local mt = { __index = Vector }
    return setmetatable( {x=x, y=y}, mt)
end

---@return number # Magnitude of the 2-D vector.
function Vector:magn()
    return math.sqrt(self:dot(self))
end

---@param v Vector # Another instance of Vector.
function Vector:dot(v)
    return self.x * v.x + self.y * v.y
end
