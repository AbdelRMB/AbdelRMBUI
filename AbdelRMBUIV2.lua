local AbdelRMBUIV2 = {}
local menuData = {}

local UIButton = load(LoadResourceFile(GetCurrentResourceName(), "items/UIButton.lua"))()
local Checkbox = load(LoadResourceFile(GetCurrentResourceName(), "items/Checkbox.lua"))()
local Slider = load(LoadResourceFile(GetCurrentResourceName(), "items/Slider.lua"))()
local List = load(LoadResourceFile(GetCurrentResourceName(), "items/List.lua"))()
local InputBox = load(LoadResourceFile(GetCurrentResourceName(), "items/InputBox.lua"))()

RegisterNetEvent("AbdelRMBUIV2:CreateMenu")
AddEventHandler("AbdelRMBUIV2:CreateMenu", function(menuId, title, subtitle)
    menuData[menuId] = { title = title, subtitle = subtitle, buttons = {} }
end)

RegisterNetEvent("AbdelRMBUIV2:CreateButton")
AddEventHandler("AbdelRMBUIV2:CreateButton", function(menuId, label)
    if menuData[menuId] then
        table.insert(menuData[menuId].buttons, label)
    else
        print("[AbdelRMBUIV2] Menu ID not found: " .. tostring(menuId))
    end
end)

RegisterNetEvent("AbdelRMBUIV2:CreateCheckbox")
AddEventHandler("AbdelRMBUIV2:CreateCheckbox", function(menuId, label, defaultState)
    if menuData[menuId] then
        local checkbox = {
            type = "checkbox",
            label = label,
            state = defaultState
        }
        table.insert(menuData[menuId].buttons, checkbox)
    end
end)


RegisterNetEvent("AbdelRMBUIV2:CreateSlider")
AddEventHandler("AbdelRMBUIV2:CreateSlider", function(menuId, label, min, max, step, defaultValue)
    if menuData[menuId] then
        local slider = {
            type = "slider",
            label = label,
            min = min,
            max = max,
            step = step,
            value = defaultValue
        }
        table.insert(menuData[menuId].buttons, slider)
    end
end)


RegisterNetEvent("AbdelRMBUIV2:CreateList")
AddEventHandler("AbdelRMBUIV2:CreateList", function(menuId, label, options, defaultIndex)
    if menuData[menuId] then
        local list = {
            type = "list",
            label = label,
            options = options,
            selectedIndex = defaultIndex
        }
        table.insert(menuData[menuId].buttons, list)
    end
end)


RegisterNetEvent("AbdelRMBUIV2:CreateInputBox")
AddEventHandler("AbdelRMBUIV2:CreateInputBox", function(menuId, label, defaultText)
    if menuData[menuId] then
        local inputBox = {
            type = "input",
            label = label,
            text = defaultText
        }
        table.insert(menuData[menuId].buttons, inputBox)
    end
end)


RegisterNetEvent("AbdelRMBUIV2:OpenMenu")
AddEventHandler("AbdelRMBUIV2:OpenMenu", function(menuId)
    if menuData[menuId] then
        local buttonsData = {}

        for _, btn in ipairs(menuData[menuId].buttons) do
            if type(btn) == "table" then
                table.insert(buttonsData, {
                    type = btn.type,
                    label = btn.label,
                    state = btn.state,
                    min = btn.min,
                    max = btn.max,
                    step = btn.step,
                    value = btn.value,
                    options = btn.options,
                    selectedIndex = btn.selectedIndex,
                    text = btn.text
                })
            else
                table.insert(buttonsData, btn) -- Pour les simples boutons
            end
        end

        -- ✅ Envoi bien les données au NUI avec debug
        print("[DEBUG] Envoi du menu à NUI : ", json.encode({
            type = "openMenu",
            title = menuData[menuId].title,
            subtitle = menuData[menuId].subtitle,
            buttons = buttonsData
        }))

        SendNUIMessage({
            type = "openMenu",
            title = menuData[menuId].title,
            subtitle = menuData[menuId].subtitle,
            buttons = buttonsData
        })
    else
        print("[AbdelRMBUIV2] Menu ID not found: " .. tostring(menuId))
    end
end)


RegisterNUICallback("setNuiFocus", function(data, cb)
    SetNuiFocus(data.focus, data.cursor)
    cb("ok")
end)


return AbdelRMBUIV2
