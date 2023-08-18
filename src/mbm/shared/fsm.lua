local Base = require "knife.base"

---@class StateMachine
local StateMachine = Base:extend()

---@return StateMachine
function StateMachine:constructor(options)
    assert(#options >= 1, "Need at least one state.")
    local names = {}
    for i, option in ipairs(options) do
        assert(options[i].name ~= nil, "Expected member 'name' in data passed to StateMachine's constructor.")
        assert(options[i].state ~= nil, "Expected member 'state' in data passed to StateMachine's constructor.")
        assert(names[option.name] == nil, "Duplicate names in data passed to StateMachine constructor.")
        names[option.name] = true
        for _, methodname in ipairs({"draw", "update"}) do
            local cond = option.state[methodname] ~= nil and type(option.state[methodname]) == "function"
            assert(cond, "One of the states supplied to StateMachine is missing a required method.")
        end
    end
    self.current = options[1]
    self.options = options
    return self
end

function StateMachine:draw()
    self.current.state:draw()
end

function StateMachine:update(dt)
    self.current.state:update(dt)
end

function StateMachine:change_to(tgtname)
    local exists = false
    for _, option in ipairs(self.options) do
        if option.name == tgtname then
            exists = true
            self.current = option
            break
        end
    end
    assert(exists, "StateMachine instance does not have a state '" .. tgtname .. "' to change to.")
    return self
end

function StateMachine:enter(tgtname)
    local exists = false
    for _, option in ipairs(self.options) do
        if option.name == tgtname then
            exists = true
            return option.state
        end
    end
    assert(exists, "StateMachine instance does not have a state '" .. tgtname .. "' to enter into.")
    return nil
end

return StateMachine
