local Checkbox = {}
Checkbox.__index = Checkbox

function Checkbox:new(label, defaultState, callback)
    local self = setmetatable({}, Checkbox)
    self.label = label
    self.state = defaultState or false
    self.callback = callback or function() end
    return self
end

function Checkbox:toggle()
    self.state = not self.state
    if self.callback then
        self.callback(self.state)
    end
end

return Checkbox
