local Slider = {}
Slider.__index = Slider

function Slider:new(label, min, max, step, defaultValue, callback)
    local self = setmetatable({}, Slider)
    self.label = label
    self.min = min or 0
    self.max = max or 100
    self.step = step or 1
    self.value = defaultValue or min
    self.callback = callback or function() end
    return self
end

function Slider:setValue(value)
    if value >= self.min and value <= self.max then
        self.value = value
        if self.callback then
            self.callback(self.value)
        end
    end
end

return Slider
