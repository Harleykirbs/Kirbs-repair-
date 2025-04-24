-- Placeholder: you can hook into your framework's job system
RegisterServerEvent("mechanic:checkJob")
AddEventHandler("mechanic:checkJob", function()
    local src = source
    local isMechanic = true -- Set false if you have job check logic

    if isMechanic then
        TriggerClientEvent("mechanic:allowRepair", src)
    else
        TriggerClientEvent('chat:addMessage', src, {
            args = { '^1You are not a mechanic!' }
        })
    end
end)


