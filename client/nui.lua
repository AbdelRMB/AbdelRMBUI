-- Gestion de la sélection d'un item
RegisterNUICallback("selectItem", function(data, cb)
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
    cb("ok")
end)

-- Gérer le retour en arrière
RegisterNUICallback("navigateBack", function(data, cb)
    local currentMenu = data.menuName
    local parentMenu = AbdelRMBUI.Menus[currentMenu] and AbdelRMBUI.Menus[currentMenu].parent

    if parentMenu then
        print("[DEBUG] Retour au menu parent:", parentMenu)
        AbdelRMBUI.OpenMenu("", parentMenu)
    else
        print("[DEBUG] Fermeture du menu:", currentMenu)
        AbdelRMBUI.CloseMenu("", currentMenu)
    end
    cb("ok")
end)

RegisterNUICallback("closeMenu", function(data, cb)
    local currentMenu = data.menuName
    if currentMenu then
        print("[DEBUG] Fermeture du menu:", currentMenu)
        AbdelRMBUI.CloseMenu("", currentMenu)
    end
    cb("ok")
end)
