local QBCore = exports['qb-core']:GetCoreObject()

-- Open Crafting Menu
RegisterNetEvent('drugs:openMenu', function()
    print("drugs:openMenu event triggered")
    local menuOptions = {}
    for drug, data in pairs(Config.Drugs) do
        print("Adding menu option for drug:", drug)
        menuOptions[#menuOptions + 1] = {
            header = drug,
            txt = "Craft " .. drug,
            params = {
                event = "drugs:craftDrug",
                args = { drug = drug }
            }
        }
    end
    exports['qb-menu']:openMenu(menuOptions)
end)

-- Craft Drug Event with Progress Bar
RegisterNetEvent('drugs:craftDrug', function(data)
    local drug = data.drug
    local ingredients = Config.Drugs[drug].ingredients

    QBCore.Functions.TriggerCallback('drugs:hasIngredients', function(hasIngredients)
        if hasIngredients then
            QBCore.Functions.Progressbar("crafting_drug", "Crafting " .. drug .. "...", 5000, false, true, { -- Adjust time as needed
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@prop_human_parking_meter@female@idle_a",
                anim = "idle_a_female",
                flags = 49,
            }, {}, {}, function() -- On success
                TriggerServerEvent('drugs:craftDrug', drug)
                ClearPedTasks(PlayerPedId())
                QBCore.Functions.Notify("Successfully crafted " .. drug .. ".", "success")
            end, function() -- On cancel
                ClearPedTasks(PlayerPedId())
                QBCore.Functions.Notify("Crafting canceled.", "error")
            end)
        else
            QBCore.Functions.Notify("You don't have the required ingredients.", "error")
        end
    end, ingredients)
end)

-- Example trigger to open the menu (you can replace this with your actual trigger)
RegisterCommand('craft', function()
    TriggerEvent('drugs:openMenu')
end)