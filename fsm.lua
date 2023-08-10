local check = require "check-self"

---@class StateMachine
local StateMachine = {
    ---@type string
    __name__ = "StateMachine",
    ---@type table<"name"|"state",unknown>
    current = {
        name = nil,
        state = nil
    },
    ---@type table<"name"|"state",unknown>[]
    options = nil
}

---@return StateMachine
function StateMachine:create(options)
    check(self, StateMachine.__name__)
    local mt = { __index = StateMachine }
    assert(#options >= 1, "Need at least one state.")
    local names = {}
    for _, option in ipairs(options) do
        assert(names[option.name] == nil, "Duplicate names in data passed to StateMachine constructor.")
        names[option.name] = true
        for _, methodname in ipairs({"draw", "new", "update"}) do
            local cond = option.state[methodname] ~= nil and type(option.state[methodname]) == "function"
            assert(cond, "One of the states supplied to StateMachine is missing a required method.")
        end
    end
    local members = {
        current = options[1],
        options = options
    }
    return setmetatable(members, mt)
end

function StateMachine:draw()
    check(self, StateMachine.__name__)
    self.current.state:draw()
end

function StateMachine:new()
    check(self, StateMachine.__name__)
    self.current.state:new()
end

function StateMachine:update(dt)
    check(self, StateMachine.__name__)
    self.current.state:update(dt)
end

function StateMachine:change_to(tgtname)
    check(self, StateMachine.__name__)
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

return StateMachine
