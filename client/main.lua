AbdelRMBUI = AbdelRMBUI or {}
AbdelRMBUI.Menus = {}
AbdelRMBUI.Callbacks = {}
local callbackCounter = 0
exports("GetAbdelRMBUI", function()
    return AbdelRMBUI
end)

function AbdelRMBUI.CreateMenu(prefix, name, title, parent)
    local fullName = prefix .. "_" .. name
    local menu = {
        title = title,
        items = {},
        isOpen = false,
        parent = parent and (prefix .. "_" .. parent) or nil
    }
    AbdelRMBUI.Menus[fullName] = menu
end

exports('CreateMenu', AbdelRMBUI.CreateMenu)

function AbdelRMBUI.Button(menuName, label, callback)
    local menu = AbdelRMBUI.Menus[menuName]
    if menu then
        callbackCounter = callbackCounter + 1
        AbdelRMBUI.Callbacks[callbackCounter] = callback

        local item = { label = label, callbackId = callbackCounter }
        table.insert(menu.items, item)
    end
end

exports('AddMenuItem', AbdelRMBUI.AddMenuItem)

function AbdelRMBUI.Input(menuName, label, defaultText, inputType, callback)
    local menu = AbdelRMBUI.Menus[menuName]
    if menu then
        callbackCounter = callbackCounter + 1
        AbdelRMBUI.Callbacks[callbackCounter] = callback

        local inputItem = { 
            type = "input", 
            label = label, 
            defaultText = defaultText or "",
            inputType = inputType or "text",
            callbackId = callbackCounter 
        }
        table.insert(menu.items, inputItem)
    end
end

exports('AddMenuInput', AbdelRMBUI.AddMenuInput)


function AbdelRMBUI.OpenMenu(prefix, name)
    local fullName = prefix .. "_" .. name
    local menu = AbdelRMBUI.Menus[fullName]
    if menu then
        menu.isOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "openMenu",
            menuTitle = menu.title,
            items = menu.items,
            menuName = fullName,
            parentMenu = menu.parent
        })
    end
end

exports('OpenMenu', AbdelRMBUI.OpenMenu)

function AbdelRMBUI.CloseMenu(prefix, name)
    local fullName = prefix .. "_" .. name
    local menu = AbdelRMBUI.Menus[fullName]
    menu.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "closeMenu" })
end

exports('CloseMenu', AbdelRMBUI.CloseMenu)

function AbdelRMBUI.ClearMenu(menuName)
    local menu = AbdelRMBUI.Menus[menuName]
    if menu then
        menu.items = {}
    end
end

exports('ClearMenu', AbdelRMBUI.ClearMenu)


RegisterNUICallback("selectItem", function(data)
    local menuName = data.menuName
    local menu = AbdelRMBUI.Menus[menuName]
    if menu then
        local selectedItem = menu.items[data.index + 1]
        if selectedItem and selectedItem.callbackId then
            local callback = AbdelRMBUI.Callbacks[selectedItem.callbackId]
            if callback then
                callback()
            end
        end
    end
end)

RegisterNUICallback("inputChange", function(data)
    local menuName = data.menuName
    local menu = AbdelRMBUI.Menus[menuName]
    if menu then
        local inputItem = menu.items[data.index + 1]
        if inputItem and inputItem.callbackId then
            local callback = AbdelRMBUI.Callbacks[inputItem.callbackId]
            if callback then
                callback(data.value)
            end
        end
    end
end)

RegisterNUICallback('releaseFocus', function(data, cb)
    SetNuiFocus(false, false) 
    cb('ok')
end)

RegisterNUICallback('goBackToParentMenu', function(data, cb)
    local parentMenu = GetParentMenu(data.menuName) 
    if parentMenu then
        SendNUIMessage({
            action = 'goBackToParentMenu',
            parentMenu = parentMenu
        })
    end
    cb('ok')
end)
