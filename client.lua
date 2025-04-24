-- Config: Require mechanic job?
local mechanicOnly = false -- Set to true if using framework and want to check job

-- Repair command
RegisterCommand("repair", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then
        if mechanicOnly then
            TriggerServerEvent("mechanic:checkJob")
        else
            startRepair(vehicle)
        end
    else
        TriggerEvent('chat:addMessage', { args = { '^1No vehicle nearby!' } })
    end
end)

-- Triggered if job is confirmed on server
RegisterNetEvent("mechanic:allowRepair")
AddEventHandler("mechanic:allowRepair", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then
        startRepair(vehicle)
    end
end)

-- Repair logic
function startRepair(vehicle)
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
    FreezeEntityPosition(PlayerPedId(), true)

    Wait(8000) -- Repair time
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)

    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)

    TriggerEvent('chat:addMessage', { args = { '^2Vehicle Repaired!' } })
end


