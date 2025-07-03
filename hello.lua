local hello = {}

hello.options = {
    cat_first = false,
    cat_second = false,
    cat_third = false,

}


-- Основная функция для работы с кнопками
local function button_click(button_name, texture_name, option_name, button_text)
    if not hello.options[option_name] then
        hello.options.cat_first = false
        hello.options.cat_second = false
        hello.options.cat_third = false
        hello.options[option_name] = true

        hello_panelFirstButton:SetText("Первая картинка" .. ": Выкл")
        hello_panelSecondButton:SetText("Вторая картинка" .. ": Выкл")
        hello_panelThirdButton:SetText("Третья картинка" .. ": Выкл")
        _G[button_name]:SetText(button_text .. ": Вкл")

        hello_panelFirstPicture:Hide()
        hello_panelSecondPicture:Hide()
        hello_panelThirdPicture:Hide()
        _G[texture_name]:Show()
    else
        hello.options[option_name] = false
        _G[button_name]:SetText(button_text .. ": Выкл")
        _G[texture_name]:Hide()
    end
end

function hello:Init()
    hello_panelFirstButton:SetScript("OnClick", function()
        button_click("hello_panelFirstButton", "hello_panelFirstPicture", "cat_first", "Первая картинка")
    end)

    hello_panelSecondButton:SetScript("OnClick", function()
        button_click("hello_panelSecondButton", "hello_panelSecondPicture", "cat_second", "Вторая картинка")
    end)

    hello_panelThirdButton:SetScript("OnClick", function()
        button_click("hello_panelThirdButton", "hello_panelThirdPicture", "cat_third", "Третья картинка")
    end)

    hello_panelExitButton:SetScript("OnClick", function()
        hello_panel:Hide()
    end)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, name)
    if name == "hello" then
        hello:Init()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)
-- Команда крч
SLASH_HELLO1 = "/hellocmd"
SlashCmdList["HELLO"] = function(msg)
    if string.lower(msg) == "options" then
        if hello_panel:IsShown() then
            hello_panel:Hide()
        else
            hello_panel:Show()
        end
    end
end
