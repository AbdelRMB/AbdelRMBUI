local AbdelRMBUIV2 = load(LoadResourceFile(GetCurrentResourceName(), "AbdelRMBUIV2.lua"))()

RegisterCommand("testmenu", function()
    TriggerEvent("AbdelRMBUIV2:CreateMenu", "menu_test", "Test Menu", "Sélectionnez une option")

    TriggerEvent("AbdelRMBUIV2:CreateButton", "menu_test", "Option 1")
    TriggerEvent("AbdelRMBUIV2:CreateButton", "menu_test", "Option 2")

    TriggerEvent("AbdelRMBUIV2:CreateCheckbox", "menu_test", "Activer le mode nuit", false)
    TriggerEvent("AbdelRMBUIV2:CreateSlider", "menu_test", "Volume", 0, 100, 10, 50)
    TriggerEvent("AbdelRMBUIV2:CreateList", "menu_test", "Choisir une couleur", {"Rouge", "Bleu", "Vert"}, 1)
    TriggerEvent("AbdelRMBUIV2:CreateInputBox", "menu_test", "Nom du joueur", "")

    TriggerEvent("AbdelRMBUIV2:OpenMenu", "menu_test")
end, false)