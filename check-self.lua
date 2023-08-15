local function check_self(self, name)
    local cond = self ~= nil and type(self) == "table" and self.__name__ == name
    assert(cond, "Expected first argument to be reference to self")
end

return check_self
