-- class defintion for a 2-D vector

Vector = {}
function Vector:new(x, y)
    assert(self ~= nil and x ~= nil and y ~= nil, "Wrong signature for call to Vector:new")
    local mt = { __index = Vector }
    return setmetatable( {x=x, y=y}, mt)
end

function Vector:magn()
    return math.sqrt(self:dot(self))
end

function Vector:dot(v)
    return self.x * v.x + self.y * v.y
end
