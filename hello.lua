local hello = CreateFrame("Frame", "hello")

hello.options = {
    cat_first = false,
    cat_second = false,
    cat_third = false,

    cat_first_path = "Interface\\AddOns\\hello\\Textures\\cat1.jpg",
    cat_second_path = "Interface\\AddOns\\hello\\Textures\\cat2.jpg",
    cat_third_path = "Interface\\AddOns\\hello\\Textures\\cat3.jpg",
}


function hello:The_Options_Window()
    self.self_panel = CreateFrame("Frame", "MyFirstAddonOptionsPanel", UIParent, "BackdropTemplate")
    local self_panel = self.self_panel
    self_panel.name = "Three Pictures"

    self_panel:SetBackdrop({
        bgFile   = "Interface/DialogFrame/UI-DialogBox-Background",
        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
        tile     = true,
        tileSize = 32,
        edgeSize = 32,
        insets   = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    self_panel:SetBackdropColor(1, 1, 1, 0.9) --
    self_panel:SetBackdropBorderColor(0.8, 0.8, 0.8, 1)

    local exit_button = CreateFrame("Button", nil, self_panel, "UIPanelButtonTemplate")
    exit_button:SetPoint("BOTTOMLEFT", self_panel, "BOTTOMLEFT", 15, 15)
    exit_button:SetSize(100, 30)
    exit_button:SetText("Убить котиков")
    exit_button:SetScript("OnClick", function()
        self_panel:Hide()
    end)

    local first_button = CreateFrame("Button", nil, self_panel, "UIPanelButtonTemplate")
    first_button:SetPoint("TOP", self_panel, "TOP", 0, -30)
    first_button:SetSize(100, 30)
    first_button:SetText("First Picture")
    first_button:SetScript("OnClick", function()
        if not hello.options.cat_first and not hello.options.cat_second == true and not hello.options.cat_third == true then
            hello.options.cat_first = true
            first_button:SetText("First Picture: ON")
            self_panel.first_picture:SetTexture(hello.options.cat_first_path)
        else
            hello.options.cat_first = false
            first_button:SetText("First Picture: OFF")
            self_panel.first_picture:SetTexture(nil)
        end
    end)

    local second_button = CreateFrame("Button", nil, self_panel, "UIPanelButtonTemplate")
    second_button:SetPoint("TOP", first_button, "TOP", 0, -40)
    second_button:SetSize(100, 30)
    second_button:SetText("Second Picture")
    second_button:SetScript("OnClick", function()
        if not hello.options.cat_second and not hello.options.cat_first == true and not hello.options.cat_third == true then
            hello.options.cat_second = true
            second_button:SetText("Second Picture: ON")
            self_panel.second_picture:SetTexture(hello.options.cat_second_path)
        else
            hello.options.cat_second = false
            second_button:SetText("Second Picture: OFF")
            self_panel.second_picture:SetTexture(nil)
        end
    end)
    local third_button = CreateFrame("Button", nil, self_panel, "UIPanelButtonTemplate")
    third_button:SetPoint("TOP", second_button, "BOTTOM", 0, -10)
    third_button:SetSize(100, 30)
    third_button:SetText("Third Picture")
    third_button:SetScript("OnClick", function()
        if not hello.options.cat_third and not hello.options.cat_second == true and not hello.options.cat_first == true then
            hello.options.cat_third = true
            third_button:SetText("Third Picture: ON")
            self_panel.third_picture:SetTexture(hello.options.cat_third_path)
        else
            hello.options.cat_third = false
            third_button:SetText("Third Picture: OFF")
            self_panel.third_picture:SetTexture(nil)
        end
    end)

    self_panel.first_picture = self_panel:CreateTexture(nil, "ARTWORK")
    self_panel.first_picture:SetSize(300, 300)
    self_panel.first_picture:SetPoint("TOP", self_panel, "TOP", 300, 50)

    self_panel.second_picture = self_panel:CreateTexture(nil, "ARTWORK")
    self_panel.second_picture:SetSize(300, 300)
    self_panel.second_picture:SetPoint("TOP", self_panel, "TOP", 300, 50)

    self_panel.third_picture = self_panel:CreateTexture(nil, "ARTWORK")
    self_panel.third_picture:SetSize(300, 300)
    self_panel.third_picture:SetPoint("TOP", self_panel, "TOP", 300, 50)

    -- Первый котик
    if hello.options.cat_first then
        self_panel.first_picture:SetTexture(hello.options.cat_first_path)
        first_button:SetText("First Picture: ON")
    else
        self_panel.first_picture:SetTexture(nil)
        first_button:SetText("First Picture: OFF")
    end

    -- Второй котик
    if hello.options.cat_second then
        self_panel.second_picture:SetTexture(hello.options.cat_second_path)
        second_button:SetText("Second Picture: ON")
    else
        self_panel.second_picture:SetTexture(nil)
        second_button:SetText("Second Picture: OFF")
    end

    -- Третий котик
    if hello.options.cat_third then
        self_panel.third_picture:SetTexture(hello.options.cat_third_path)
        third_button:SetText("Third Picture: ON")
    else
        self_panel.third_picture:SetTexture(nil)
        third_button:SetText("Third Picture: OFF")
    end

    self_panel:SetSize(300, 200)
    self_panel:SetPoint("CENTER")
    self_panel:SetMovable(true)
    self_panel:EnableMouse(true)
    self_panel:Hide()
end

function hello:OnEvent(event, addon_name)
    if event == "ADDON_LOADED" and addon_name == "hello" then
        self:The_Options_Window()
    end
end

SLASH_HELLO1 = "/hellocmd"
SlashCmdList["HELLO"] = function(msg)
    local command_for_zapustis_bliat = string.lower(msg)
    if command_for_zapustis_bliat == "options" then
        if not hello.self_panel then
            hello:The_Options_Window()
        end

        if hello.self_panel:IsShown() then
            hello.self_panel:Hide()
        else
            hello.self_panel:Show()
        end
    end
end

hello:RegisterEvent("ADDON_LOADED")
hello:SetScript("OnEvent", hello.OnEvent)
