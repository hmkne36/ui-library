local UI = {}
UI.__index = UI

print("AccuUI v1 (Stable) is loaded!!")

function UI:CreateWindow(titleText)
    local self = setmetatable({}, UI)

    local TweenService = game:GetService("TweenService")

    local function tween(obj, props, t)
        TweenService:Create(obj, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "UIFramework"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0,270,0,340)
    Main.Position = UDim2.new(0.05,0,0.3,0)
    Main.BackgroundColor3 = Color3.fromRGB(18,18,24)
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = Color3.fromRGB(100,80,255)
    Stroke.Transparency = 0.5

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1,0,0,50)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20

    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1,-20,0,230)
    Container.Position = UDim2.new(0,10,0,60)
    Container.BackgroundTransparency = 1

    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0,10)

    local Footer = Instance.new("TextLabel", Main)
    Footer.Position = UDim2.new(0,0,1,-28)
    Footer.Size = UDim2.new(1,0,0,20)
    Footer.BackgroundTransparency = 1
    Footer.Text = "by Hmkkk"
    Footer.TextColor3 = Color3.fromRGB(180,180,200)
    Footer.Font = Enum.Font.GothamBold
    Footer.TextSize = 13

    local minimized = false

    local Min = Instance.new("TextButton", Main)
    Min.Size = UDim2.new(0,25,0,25)
    Min.Position = UDim2.new(1,-65,0,12)
    Min.Text = "▼"
    Min.BackgroundTransparency = 1
    Min.TextColor3 = Color3.new(1,1,1)

    Min.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Min.Text = "▲"
            Container.Visible = false
            Footer.Visible = false
            tween(Main,{Size = UDim2.new(0,270,0,70)})
        else
            Min.Text = "▼"
            Container.Visible = true
            Footer.Visible = true
            tween(Main,{Size = UDim2.new(0,270,0,340)})
        end
    end)

    local Close = Instance.new("TextButton", Main)
    Close.Size = UDim2.new(0,25,0,25)
    Close.Position = UDim2.new(1,-35,0,12)
    Close.Text = "✕"
    Close.BackgroundTransparency = 1
    Close.TextColor3 = Color3.fromRGB(255,120,120)

    local Overlay = Instance.new("Frame", ScreenGui)
    Overlay.Size = UDim2.new(1,0,1,0)
    Overlay.BackgroundColor3 = Color3.new(0,0,0)
    Overlay.BackgroundTransparency = 1
    Overlay.Visible = false
    Overlay.Active = false

    local Confirm = Instance.new("Frame", Overlay)
    Confirm.Size = UDim2.new(0,0,0,0)
    Confirm.Position = UDim2.new(0.5,-125,0.5,-65)
    Confirm.BackgroundColor3 = Color3.fromRGB(25,25,30)
    Instance.new("UICorner", Confirm).CornerRadius = UDim.new(0,16)

    local Txt = Instance.new("TextLabel", Confirm)
    Txt.Size = UDim2.new(1,-20,0.5,0)
    Txt.Position = UDim2.new(0,10,0,10)
    Txt.BackgroundTransparency = 1
    Txt.Text = "Are you sure you want to close this UI?"
    Txt.TextWrapped = true
    Txt.TextColor3 = Color3.new(1,1,1)
    Txt.Font = Enum.Font.GothamBold
    Txt.TextSize = 14

    local Yes = Instance.new("TextButton", Confirm)
    Yes.Size = UDim2.new(0.4,0,0.25,0)
    Yes.Position = UDim2.new(0.1,0,0.65,0)
    Yes.Text = "Yes"
    Yes.BackgroundColor3 = Color3.fromRGB(90,70,255)
    Yes.TextColor3 = Color3.new(1,1,1)
    Yes.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Yes)

    local No = Instance.new("TextButton", Confirm)
    No.Size = UDim2.new(0.4,0,0.25,0)
    No.Position = UDim2.new(0.5,0,0.65,0)
    No.Text = "No"
    No.BackgroundColor3 = Color3.fromRGB(40,40,50)
    No.TextColor3 = Color3.new(1,1,1)
    No.Font = Enum.Font.GothamBold
    Instance.new("UICorner", No)

    Close.MouseButton1Click:Connect(function()
        Overlay.Visible = true
        Overlay.Active = true
        tween(Overlay,{BackgroundTransparency = 0.4},0.2)
        tween(Confirm,{Size = UDim2.new(0,250,0,130)},0.25)
    end)

    No.MouseButton1Click:Connect(function()
        tween(Overlay,{BackgroundTransparency = 1},0.2)
        tween(Confirm,{Size = UDim2.new(0,0,0,0)},0.2)
        task.wait(0.2)
        Overlay.Visible = false
        Overlay.Active = false
    end)

    Yes.MouseButton1Click:Connect(function()
        tween(Main,{Size = UDim2.new(0,0,0,0)},0.25)
        task.wait(0.25)
        ScreenGui:Destroy()
    end)

    self.Container = Container
    return self
end

function UI:CreateToggle(text, callback, isLoop)
    local Frame = Instance.new("Frame", self.Container)
    Frame.Size = UDim2.new(1,0,0,42)
    Frame.BackgroundColor3 = Color3.fromRGB(26,26,34)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,12)

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = text
    Label.Size = UDim2.new(0.7,0,1,0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(230,230,240)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14

    local Box = Instance.new("TextButton", Frame)
    Box.Size = UDim2.new(0,42,0,22)
    Box.Position = UDim2.new(0.75,0,0.5,-11)
    Box.BackgroundColor3 = Color3.fromRGB(50,50,65)
    Box.Text = ""
    Instance.new("UICorner", Box).CornerRadius = UDim.new(1,0)

    local Circle = Instance.new("Frame", Box)
    Circle.Size = UDim2.new(0,18,0,18)
    Circle.Position = UDim2.new(0,2,0.5,-9)
    Circle.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", Circle)

    local active = false

    Box.MouseButton1Click:Connect(function()
        active = not active
        if active then
            Box.BackgroundColor3 = Color3.fromRGB(0,200,120)
            Circle:TweenPosition(UDim2.new(1,-20,0.5,-9),"Out","Quad",0.2,true)
            if isLoop then
                task.spawn(function()
                    while active do
                        callback(true)
                        task.wait(0.1)
                    end
                end)
            else
                callback(true)
            end
        else
            Box.BackgroundColor3 = Color3.fromRGB(50,50,65)
            Circle:TweenPosition(UDim2.new(0,2,0.5,-9),"Out","Quad",0.2,true)
            callback(false)
        end
    end)
end

return UI
