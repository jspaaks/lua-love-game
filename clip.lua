local function clip(value, bounds)
    assert(value and bounds[1] and bounds[2], "Invalid arguments supplied to function 'clip'.")
    assert(type(value) == "number", "First argument should be a number")
    assert(type(bounds) == "table", "Second argument should be a table.")
    assert(#bounds == 2, "Second argument should be a table with 2 elements.")
    assert(bounds[1] < bounds[2], "Boundaries should be in increasing order.")
    return math.min(bounds[2], math.max(bounds[1], value))
end

return clip
