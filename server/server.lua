local QBCore = exports['qb-core']:GetCoreObject()

-- Craft Drug Event
RegisterNetEvent('S-drugs:craftDrug', function(drug)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then
        print("Player not found for source:", src)
        return
    end

    local drugConfig = Config.S-drugs[drug]
    if not drugConfig or not drugConfig.ingredients then
        print("Invalid drug configuration for drug:", drug)
        DropPlayer(src, "Invalid crafting attempt.")
        return
    end

    local ingredients = drugConfig.ingredients
    for _, item in pairs(ingredients) do
        if not Player.Functions.GetItemByName(item) then
            print("Player missing ingredient:", item)
            DropPlayer(src, "Invalid crafting attempt.")
            return
        end
    end

    for _, item in pairs(ingredients) do
        Player.Functions.RemoveItem(item, 1)
    end
    Player.Functions.AddItem(drugConfig.result, 1)
    TriggerClientEvent('QBCore:Notify', src, "You crafted " .. drug .. ".", "success")
end)

-- Check Ingredients Callback
QBCore.Functions.CreateCallback('S-drugs:hasIngredients', function(source, cb, ingredients)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        print("Player not found for source:", source)
        cb(false)
        return
    end

    if not ingredients or type(ingredients) ~= "table" then
        print("Invalid ingredients table")
        cb(false)
        return
    end

    for _, item in pairs(ingredients) do
        if not Player.Functions.GetItemByName(item) then
            print("Player missing ingredient:", item)
            cb(false)
            return
        end
    end
    cb(true)
end)