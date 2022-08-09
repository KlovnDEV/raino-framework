RegisterServerEvent('MP-Logs:Server:CheckPlayerOnServer')
AddEventHandler('MP-Logs:Server:CheckPlayerOnServer', function()
    local playerOn = {}
    local players = GetPlayers()
    for i, player in pairs(players) do
        local player = tonumber(player)
        table.insert(playerOn, player)
    end
    TriggerClientEvent('MP-Logs:Client:CheckPlayer', -1 , i)
end)

AddEventHandler('onResourceStart', function(resname)
    TriggerClientEvent('MP-Logs:Client:CheckPlayer', -1 , i)
end)