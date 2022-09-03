local ProgressBar = {}
ProgressBar.__index = ProgressBar

local GV = require(script.Parent.Parent.PluginGlobalVariables)
local util = require(GV.LibraryDir.GUIUtil)
local GUIObject = require(GV.ObjectsDir.GUIObject)
local ColorManager = require(GV.ManagersDir.ColorManager)
setmetatable(ProgressBar,GUIObject)

function ProgressBar:SetDisabled(State)
    self.Disabled = State
    if self.Disabled then
        self.ProgressBar.BackgroundTransparency, self.ProgressIndicator.BackgroundTransparency = 0.5, 0.5
    else
        self.ProgressBar.BackgroundTransparency, self.ProgressIndicator.BackgroundTransparency = 0, 0
    end
end

function ProgressBar:ToggleDisable()
    self:SetDisabled(not self.Disabled)
end

function ProgressBar:SetValue(Value)
    self.Value = Value
    self.ProgressIndicator.Size = UDim2.new(self.Value,0,1,0)
end

-- Size, Value, Disabled
function ProgressBar.new(Arguments, Parent)
    local self = GUIObject.new(Arguments, Parent)
    setmetatable(self,ProgressBar)
    self.ProgressBarContainer = Instance.new("Frame", self.Parent)
    self.ProgressBarContainer.Name = "ProgressBarContainer"
    self.ProgressBarContainer.BackgroundTransparency = 1
    self.ProgressBarContainer.Size = UDim2.new(1,0,1,0)
    self.ProgressBar = Instance.new("Frame", self.ProgressBarContainer)
    self.ProgressBar.Name = "ProgressBar"
    self.ProgressBar.AnchorPoint = Vector2.new(0.5,0.5)
    local Size = util.GetScale(self.Arguments.Size) or UDim.new(1,-12)
    self.ProgressBar.Size = UDim2.new(Size.Scale,Size.Offset,0,16)
    self.ProgressBar.Position = UDim2.new(0.5,0,0.5,0)
    ColorManager.ColorSync(self.ProgressBar, "BackgroundColor3", Enum.StudioStyleGuideColor.InputFieldBackground)
    ColorManager.ColorSync(self.ProgressBar, "BorderColor3", Enum.StudioStyleGuideColor.InputFieldBorder)
    self.ProgressIndicator = Instance.new("Frame", self.ProgressBar)
    self.ProgressIndicator.Name = "Indicator"
    self:SetValue(self.Arguments.Value)
    self.ProgressIndicator.BorderSizePixel = 0
    ColorManager.ColorSync(self.ProgressIndicator, "BackgroundColor3", Enum.StudioStyleGuideColor.LinkText, nil, true)
    self:SetDisabled(self.Arguments.Disabled)
    self.Object = self.ProgressIndicator
    self.MainMovable = self.ProgressBarContainer
    return self
end

return ProgressBar