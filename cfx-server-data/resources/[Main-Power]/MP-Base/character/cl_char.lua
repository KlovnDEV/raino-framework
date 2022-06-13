local selectingChar = false 
local cam  = nil
local cam2 = nil

local bannedNames = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if NetworkIsSessionStarted() then 
            TriggerServerEvent('MP-Base:Char:Joined')
            TriggerEvent('MP-Base:Char:StartCamera')
            TriggerEvent('MP-ui:client:CloseCharUI')
            TriggerEvent('MP-Base:PlayerLogin')
            selectedChar(true)
            return
        end
    end
end)

RegisterNetEvent('MP-Base:Char:Selecting')
AddEventHandler('MP-Base:Char:Selecting', function()
    selectedChar(true)
end)

GetCID = function(source, cb)
    local src = source
    TriggerServerEvent('MP-Base:GetID', src)
end

RegisterNUICallback('createCharacter', function(data)
    local CharData = data.CharData
    for theData, value in pains(CharData) do
        if theData == 'firstname' or theData == 'lastname' then 
            reason = verifyName(value)
            print(reason) -- make sure this prints out correctly comment// remove later

            if reason ~= '' then
                break
            end
        end
    end

    if reason == '' then 
        TriggerServerEvent('MP-Base:server:createCharacter', CharData)
    end
end)

function verifyName(name)
    for k, v in ipairs(bannedNames) do
        if name == v  then 
            local reason = "Trying to use inappropriate name and ruin the fun for everyone. Please think about your choices or never come back to the server! "           
            TriggerServerEvent("MP-Admin:Disconnect", reason)
        end
    end

    local nameLength = string.len(name)
    if nameLength > 25 or nameLength < 2 then 
        return 'Your Name Is too short or long'
    end

    local count = 0
	for i in name:gmatch("[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-]") do
		count = count + 1
	end
	if count ~= nameLength then
		return "Your player name contains special characters that are not allowed on this server."
	end

	local spacesInName = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, "%S+") do
		if string.match(word, "%u") then
			spacesWithUpper = spacesWithUpper + 1
		end
        
		spacesInName = spacesInName + 1
	end

	if spacesInName > 1 then
		return "Your name contains more than two spaces"
	end

	if spacesWithUpper ~= spacesInName then
		return "your name must start with a capital letter."
	end

	return ""
end

RegisterNUICallback('deleteCharacter', function(data)
    local CharData = data 
    TriggerServerEvent('MP-Base:deleteChar', CharData)
end)

RegisterNetEvent('MP-Base:Char:setupCharacter')
AddEventHandler('MP-Base:Char:setupCharacter', function()
    MP.Functions.TriggerServerCallback('MP-Base:GetChar', function(data)
        SendNUIMessage({type = 'setupCharacters', characters = data})
    end)
end)

RegisterNUICallback('selectCharacters', function(data)
    local cid = tonumber(data.cid)
    selectedChar(false)
    TriggerServerEvent('MP-Base:Char:ServerSelect', cid)
    TriggerEvent('MP-Spawn:openMenu')
    SetTimecycleModifier('default')
    SetCamActive(cam, false)
    DestroyCam(cam, false)
end)

RegisterNUICallback('CloseChar', function()
    selectedChar(false)
end)

function selectedChar(value)
    SetNuiFocus(value, value)
    SendNUIMessage({
        type = 'charSelect',
        status = value
    })
    selectingChar = false
end

RegisterNetEvent('MP-Base:Char:StartCam')
AddEventHandler('MP-Base:Char:StartCam', function()
    DoScreenFadeIn(10)
    SetTimecycleModifier('hud_def_blur')
    SetTimecycleModifierStrength(1.0)
    FreezeEntityPosition(GetPlayedPed(-1), true)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -358.56, -981.96, 286.25, 320.00, 0.00, -50.00, 90.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true,false,1,true,true)
end)