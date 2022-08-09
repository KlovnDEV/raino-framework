Citizen.CreateThread(function()
    while true do
        SetDiscordAppId(MP.Discord.idBot)
        SetDiscordRichPresenceAsset(MP.Discord.AssetImage)
        SetDiscordRichPresenceAssetText(MP.Discord.AssetText)
        SetDiscordRichPresenceAssetSmall(MP.Discord.SmallAssetImg)
        SetDiscordRichPresenceAssetSmallText(MP.Discord.SmallAssetText)
        if MP.Discord.ButtonActive then 
            SetDiscordRichPresenceAction(0, MP.Discord.ActionButtonName1, MP.Discord.AssetDescriptionName1)
            SetDiscordRichPresenceAction(0, MP.Discord.ActionButtonName2, MP.Discord.AssetDescriptionName2)
        end
        Wait(MP.Discord.Wait)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(MP.Discord.CheckWait)
        TriggerServerEvent('MP-Logs:Server:CheckPlayerOnServer')
    end
end)

RegisterNetEvent('MP-Logs:Client:CheckPlayer')
AddEventHandler('MP-Logs:Client:CheckPlayer', function(playerOn)
    local playerName = GetPlayerName(PlayerId())
    local playeronline = #playerOn
    SetRichPresence(playerName .. ' - '.. playeronline .. '/' .. MP.Discord.SlotFiveM)
end)