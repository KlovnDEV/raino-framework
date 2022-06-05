function MP.Base.Start(self)
    Citizen.CreateThread(function()
        while true do
            if NetworkIsSessionStarted() then 
                TriggerEvent('MP-Base:Start')
                TriggerServerEvent('MP-Base:ServerStart')
                break
            end
        end
    end)
end
MP.Base.Start(self)

RegisterNetEvent('MP-Base:client:getObject')
AddEventHandler('MP-Base:client:getObject', function(callback)
    callback(MP)
    print('Called Back ' .. MP .. )
end)
