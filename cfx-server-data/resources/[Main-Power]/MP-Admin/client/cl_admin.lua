local blank = -1 
RegisterNetEvent('MP-Admin:Client:SaveCoords')
AddEventHandler('MP-Admin:Client:SaveCoords', function()
    blank = blank +1 -- set to 0 on default
    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    TriggerServerEvent('MP-Admin:SaveCoords', blank, x, y, z)
end)

RegisterNetEvent('MP-Admin:SpawnVehicle')
AddEventHandler('MP-Admin:SpawnVehicle', function(vehicle)
    local PlayerPos = GetEntityCoords(GetPlayerPed(-1))
    RequestModel(GetHashKey(vehicle))
    if not IsModelValid(GetHashKey(vehicle)) then 
        Wait(0)
    end
    CreateVehicle(GetHashKey(vehicle), PlayerPos.x, PlayerPos.y, PlayerPos.z, 200, 1,0 )
end)