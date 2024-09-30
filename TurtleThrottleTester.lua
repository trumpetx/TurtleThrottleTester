local TurtleThrottleTester = CreateFrame("Frame")

TurtleThrottleTester.Warmup = GetTime() + 6
TurtleThrottleTester.TestLength = TurtleThrottleTester.Warmup + 10
TurtleThrottleTester.Chats = 0
TurtleThrottleTester.Throttled = 0
TurtleThrottleTester.ChannelIndex = 0
TurtleThrottleTester.OnUpdateDelay = 0
TurtleThrottleTester.TurtleThrottle = 0
TurtleThrottleTester.TestDone = false
TurtleThrottleTester.Delay = .85

TurtleThrottleTester:RegisterEvent("UI_ERROR_MESSAGE")
TurtleThrottleTester:SetScript("OnEnter", function() this:SetOwner(this, "ANCHOR_NONE") end)
TurtleThrottleTester:SetScript("OnEvent", function()
    local self = TurtleThrottleTester
    for seconds in string.gfind(arg1, "You must wait ([0-9]+) Seconds. before speaking again.") do
        if GetTime() > self.TurtleThrottle then
            self.Throttled = self.Throttled + 1
            DEFAULT_CHAT_FRAME:AddMessage("|cffff0000"..arg1)
        end
        self.Chats = self.Chats - 1
        self.TurtleThrottle=GetTime() + tonumber(seconds) + .1
    end
end)
TurtleThrottleTester:SetScript("OnUpdate", function()
    local self = TurtleThrottleTester
    if self.TestDone then return end
    self.OnUpdateDelay = self.OnUpdateDelay + arg1;
    if self.OnUpdateDelay < TurtleThrottleTester.Delay then
        return;
    end
    self.OnUpdateDelay = 0;
    local now = GetTime()
    if now < self.Warmup or now < self.TurtleThrottle then 
        self.ChannelIndex = GetChannelName("TTT")
        return
    end
    if now > self.TestLength then
        self.TestDone = true
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Test Complete: " .. self.Chats .. " chat messages sent and " .. self.Throttled .. " mute mesages over " .. (self.TestLength - self.Warmup) .. " seconds")
    elseif self.ChannelIndex > 0 then
        self.Chats = self.Chats + 1
        SendChatMessage("This is a turtle throttle test " .. self.Chats, "CHANNEL", nil, self.ChannelIndex);
    end
end);