local InputBox = {}
InputBox.__index = InputBox

function InputBox:new(label, defaultText, callback)
    local self = setmetatable({}, InputBox)
    self.label = label
    self.text = defaultText or ""
    self.callback = callback or function() end
    return self
end

function InputBox:setText(newText)
    self.text = newText
    if self.callback then
        self.callback(self.text)
    end
end

return InputBox
