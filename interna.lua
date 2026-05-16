local LeaveBtn = createGrayButton("LEAVE BUTTON")
LeaveBtn.MouseButton1Click:Connect(function()
    -- Delta Injector Script for Roblox: Steal a brainrot
    -- Created by Colin
    
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    -- Create main GUI
    local ScreenGui = Instance.new("ScreenGui")
    local LeaveButton = Instance.new("TextButton")
    
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "DeltaScript"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Leave Button
    LeaveButton.Name = "LeaveButton"
    LeaveButton.Parent = ScreenGui
    LeaveButton.BackgroundColor3 = Color3.new(0, 0, 0)
    LeaveButton.BorderColor3 = Color3.new(1, 1, 1)
    LeaveButton.BorderSizePixel = 2
    LeaveButton.Position = UDim2.new(0, 10, 0, 10)
    LeaveButton.Size = UDim2.new(0, 80, 0, 40)
    LeaveButton.Font = Enum.Font.SourceSansBold
    LeaveButton.Text = "LEAVE"
    LeaveButton.TextColor3 = Color3.new(1, 1, 1)
    LeaveButton.TextSize = 14
    LeaveButton.Active = true
    LeaveButton.Draggable = true
    
    -- Mobile dragging functionality for Leave button
    local leaveDragging = false
    local leaveDragInput, leaveDragStart, leaveStartPos
    
    local function updateLeaveInput(input)
        local delta = input.Position - leaveDragStart
        LeaveButton.Position = UDim2.new(leaveStartPos.X.Scale, leaveStartPos.X.Offset + delta.X, 
                                        leaveStartPos.Y.Scale, leaveStartPos.Y.Offset + delta.Y)
    end
    
    LeaveButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            -- Start dragging only if holding for more than 0.3 seconds
            local dragStartTime = tick()
            leaveDragStart = input.Position
            leaveStartPos = LeaveButton.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    -- If tap was shorter than 0.3 seconds, it's a click
                    if tick() - dragStartTime < 0.3 then
                        -- Leave function
                        localPlayer:Kick("Left by script")
                    end
                    leaveDragging = false
                end
            end)
            
            -- Wait a bit before enabling dragging to prevent accidental clicks
            wait(0.3)
            leaveDragging = true
        end
    end)
    
    LeaveButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            leaveDragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == leaveDragInput and leaveDragging then
            updateLeaveInput(input)
        end
    end)
    
    print("Leave Button создана на экране")
end)
