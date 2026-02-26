local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Library = {}
Library.__index = Library

function Library:CreateWindow(title)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomUILibrary"
    ScreenGui.Parent = game.CoreGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0,500,0,320)
    Main.Position = UDim2.new(0.5,-250,0.5,-160)
    Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Instance.new("UICorner",Main).CornerRadius = UDim.new(0,6)

    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(1,0,0,34)
    Top.BackgroundTransparency = 1
    Top.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,-40,1,0)
    Title.Position = UDim2.new(0,10,0,0)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Window"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Top

    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0,30,1,0)
    Close.Position = UDim2.new(1,-30,0,0)
    Close.BackgroundTransparency = 1
    Close.Text = "X"
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 16
    Close.TextColor3 = Color3.fromRGB(255,255,255)
    Close.Parent = Top

    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Tabs = Instance.new("Frame")
    Tabs.Size = UDim2.new(0,110,1,-34)
    Tabs.Position = UDim2.new(0,0,0,34)
    Tabs.BackgroundTransparency = 1
    Tabs.Parent = Main
    Instance.new("UIListLayout",Tabs).Padding = UDim.new(0,6)

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1,-110,1,-34)
    Content.Position = UDim2.new(0,110,0,34)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    local Window = {}
    Window.Pages = {}

    function Window:SetTitle(text)
        Title.Text = text
    end

    function Window:AddTab(name)

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1,-10,0,30)
        Button.Position = UDim2.new(0,5,0,0)
        Button.BackgroundTransparency = 1
        Button.Text = name
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 13
        Button.TextColor3 = Color3.fromRGB(180,180,180)
        Button.Parent = Tabs

        local Page = Instance.new("Frame")
        Page.Size = UDim2.new(1,0,1,0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.Parent = Content

        local Layout = Instance.new("UIListLayout")
        Layout.Padding = UDim.new(0,8)
        Layout.Parent = Page

        Window.Pages[name] = Page

        Button.MouseButton1Click:Connect(function()

            for _,v in pairs(Window.Pages) do
                v.Visible = false
            end

            for _,v in pairs(Tabs:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v,TweenInfo.new(0.15),{TextColor3 = Color3.fromRGB(180,180,180)}):Play()
                end
            end

            TweenService:Create(Button,TweenInfo.new(0.15),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()

            Page.Visible = true

        end)

        local Tab = {}

        function Tab:AddButton(text,callback)

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1,-20,0,30)
            Btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Btn.BorderSizePixel = 0
            Btn.Text = text
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 13
            Btn.TextColor3 = Color3.fromRGB(255,255,255)
            Btn.Parent = Page
            Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,4)

            Btn.MouseButton1Click:Connect(callback)

        end

        function Tab:AddToggle(text,default,callback)

            local state = default

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1,-20,0,30)
            Btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Btn.BorderSizePixel = 0
            Btn.Text = text..": "..(state and "ON" or "OFF")
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 13
            Btn.TextColor3 = Color3.fromRGB(255,255,255)
            Btn.Parent = Page
            Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,4)

            Btn.MouseButton1Click:Connect(function()

                state = not state
                Btn.Text = text..": "..(state and "ON" or "OFF")

                callback(state)

            end)

        end

        function Tab:AddSlider(text,min,max,default,callback)

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1,-20,0,50)
            Frame.BackgroundTransparency = 1
            Frame.Parent = Page

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1,0,0,20)
            Label.BackgroundTransparency = 1
            Label.Text = text..": "..default
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 13
            Label.TextColor3 = Color3.fromRGB(255,255,255)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Frame

            local Bar = Instance.new("Frame")
            Bar.Size = UDim2.new(1,0,0,6)
            Bar.Position = UDim2.new(0,0,0,30)
            Bar.BackgroundColor3 = Color3.fromRGB(30,30,30)
            Bar.BorderSizePixel = 0
            Bar.Parent = Frame
            Instance.new("UICorner",Bar).CornerRadius = UDim.new(1,0)

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
            Fill.BackgroundColor3 = Color3.fromRGB(255,255,255)
            Fill.BorderSizePixel = 0
            Fill.Parent = Bar
            Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)

            local dragging = false

            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)

            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            UIS.InputChanged:Connect(function(input)

                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

                    local percent = math.clamp((input.Position.X - Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,0,1)

                    Fill.Size = UDim2.new(percent,0,1,0)

                    local value = math.floor(min + (max-min)*percent)

                    Label.Text = text..": "..value

                    callback(value)

                end

            end)

        end

        function Tab:AddDropdown(text,options,callback)

            local Open = false
            local Selected = options[1]

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1,-20,0,30)
            Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Frame.BorderSizePixel = 0
            Frame.Parent = Page
            Instance.new("UICorner",Frame).CornerRadius = UDim.new(0,4)

            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1,0,1,0)
            Button.BackgroundTransparency = 1
            Button.Text = text..": "..Selected
            Button.Font = Enum.Font.Gotham
            Button.TextSize = 13
            Button.TextColor3 = Color3.fromRGB(255,255,255)
            Button.Parent = Frame

            local List = Instance.new("Frame")
            List.Size = UDim2.new(1,0,0,#options*28)
            List.Position = UDim2.new(0,0,1,4)
            List.BackgroundColor3 = Color3.fromRGB(20,20,20)
            List.Visible = false
            List.Parent = Frame
            Instance.new("UICorner",List).CornerRadius = UDim.new(0,4)

            local Layout = Instance.new("UIListLayout")
            Layout.Parent = List

            for _,opt in pairs(options) do

                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1,0,0,28)
                OptBtn.BackgroundTransparency = 1
                OptBtn.Text = opt
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextSize = 13
                OptBtn.TextColor3 = Color3.fromRGB(200,200,200)
                OptBtn.Parent = List

                OptBtn.MouseButton1Click:Connect(function()

                    Selected = opt
                    Button.Text = text..": "..opt
                    List.Visible = false
                    callback(opt)

                end)

            end

            Button.MouseButton1Click:Connect(function()

                Open = not Open
                List.Visible = Open

            end)

        end

        return Tab

    end

    local drag = false
    local dragInput
    local dragStart
    local startPos

    Top.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 then

            drag = true
            dragStart = input.Position
            startPos = Main.Position

            input.Changed:Connect(function()

                if input.UserInputState == Enum.UserInputState.End then
                    drag = false
                end

            end)

        end

    end)

    Top.InputChanged:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end

    end)

    UIS.InputChanged:Connect(function(input)

        if input == dragInput and drag then

            local delta = input.Position - dragStart

            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )

        end

    end)

    return Window

end

return Library
