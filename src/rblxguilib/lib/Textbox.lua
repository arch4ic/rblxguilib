local Textbox = {}
Textbox.__index = Textbox

local util = require(script.Parent.Util)
local ListFrame = require(script.Parent.ListFrame)
local GUIObject = require(script.Parent.GUIObject)
setmetatable(Textbox,GUIObject)

function Textbox.new(text, font, alignment, parent)
    local self = GUIObject.new()
    if not parent then
        parent = ListFrame.new().Frame
        parent.Name = "TextFrame"
    end
    setmetatable(self,Textbox)
    if not alignment then alignment = Enum.TextXAlignment.Center end
    if not font then font = Enum.Font.SourceSans end
    self.Textbox = Instance.new("TextLabel", parent)
    self.Textbox.BackgroundTransparency = 1
    self.Textbox.Size = UDim2.new(1,0,1,0)
    self.Textbox.TextXAlignment = alignment
    self.Textbox.TextSize = 15
    self.Textbox.Font = font
    self.Textbox.Text = text
    util.ColorSync(self.Textbox, "TextColor3", Enum.StudioStyleGuideColor.MainText)
    return self
end

return Textbox