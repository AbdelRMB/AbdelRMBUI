local List = {}
List.__index = List

function List:new(label, options, defaultIndex, callback)
    local self = setmetatable({}, List)
    self.label = label
    self.options = options or {}
    self.selectedIndex = defaultIndex or 1
    self.callback = callback or function() end
    return self
end

function List:selectNext()
    self.selectedIndex = (self.selectedIndex % #self.options) + 1
    self.callback(self.options[self.selectedIndex])
end

function List:selectPrevious()
    self.selectedIndex = (self.selectedIndex - 2 + #self.options) % #self.options + 1
    self.callback(self.options[self.selectedIndex])
end

return List
