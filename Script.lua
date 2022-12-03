--Already Running--
if getgenv()["Already Running"] then return else getgenv()["Already Running"] = "" end
--Services--
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
--Vars--
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local flags = {Auto_Clicking = false}
--Mouse-- 
local Mouse = setmetatable({}, {
    __index = function(table, index)
        return UIS:GetMouseLocation()[index]
    end
})
--Get Keybind--
local getKeycode = function(bind)
    return (pcall(function() return (Enum.KeyCode[bind]) end) and Enum.KeyCode[bind] or bind)
end
--Draw--
local Draw = function(obj, props)
    local NewObj = Drawing.new(obj)

    for i, v in next, props do
        NewObj[i] = v
    end

    return NewObj
end
--Create GUI--
local Text = Draw("Text", {
    Size = 18,
    Outline = true,
    OutlineColor = Color3.fromRGB(255, 255, 255),
    Color = Color3.fromRGB(0, 0, 0),
    Text = "Auto Clicking : FALSE",
    Visible = true,
})
--Key Bind--
UIS.InputBegan:Connect(function(inputObj, GPE)
    if (not GPE) then
        if (inputObj.KeyCode == getKeycode(Settings["Auto Click Keybind"])) then
            flags.Auto_Clicking = not flags.Auto_Clicking
        end

        Text.Text = ("Auto Clicking : %s"):format(tostring(flags.Auto_Clicking):upper())
    end
end)
--Auto Click--
coroutine.wrap(function()
    while (true) do
        Text.Visible = Settings.GUI
        Text.Position = Vector2.new(Camera.ViewportSize.X - 133, Camera.ViewportSize.Y - 32)

        if (Settings.Delay <= 0) then
            RunService.RenderStepped:Wait()
        else
            wait(Settings.Delay)
        end
    end
end)()
