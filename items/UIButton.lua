local UIButton = {}
UIButton.__index = UIButton

---@param label string
---@param callback function
function UIButton:new(label, callback)
    local self = setmetatable({}, UIButton)
    self.label = label
    self.callback = callback or function() end
    return self
end

function UIButton:trigger()
    if self.callback then
        self.callback()
    end
end

return UIButton
