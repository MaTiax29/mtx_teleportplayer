ESX = nil

-- Threads
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    SpawnPed()
end)

Citizen.CreateThread(function()
    while true do
        local sec = 750
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k,v in pairs(Config['Settings']) do
            local dist = Vdist(coords, vector3(v.coords.x, v.coords.y, v.coords.z))

            if dist < Config['Distance'] then
                sec = 0
                ShowFloatingHelpNotification(Config['Locales'][Config['Locale']].Text, vector3(v.coords.x, v.coords.y, v.coords.z + 1.0))
                if IsControlJustPressed(1, Config['Key']) then
                    TriggerEvent('mtx_teleportplayer:MenuPoints')
                end
            end
        end
        Citizen.Wait(sec)
    end
end)

-- Events
RegisterNetEvent('mtx_teleportplayer:MenuPoints', function()
    for k,v in pairs(Config['Points']) do
        TriggerEvent('nh-context:sendMenu', {
            {
                id = v.id,
                header = v.label,
                txt = v.txt,
                params = {
                    event = 'mtx_teleportplayer:TeleportPlayer',
                    args = {
                        ubi = v.coords,
                        name = v.label,
                    }
                }
            }
        })
    end
end)

RegisterNetEvent('mtx_teleportplayer:TeleportPlayer')
AddEventHandler('mtx_teleportplayer:TeleportPlayer', function(data)

    local ped = PlayerPedId()

    if data.ubi ~= nil then
        ESX.SetTimeout(Config['Cooldown'], function()
            SetEntityCoords(ped, data.ubi.x, data.ubi.y, data.ubi.z, true, true, false, false)
            ShowNotification(Config['Locales'][Config['Locale']].Notify..data.name)
        end)
    end

end)

-- Functions
SpawnPed = function()
    for k,v in pairs(Config['Settings']) do
        local PED = GetHashKey(v.model)
        RequestModel(PED)
        while not HasModelLoaded(PED) do
            Citizen.Wait(1)
        end
    
        ped = CreatePed(5, PED, v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.h, false, true)
        SetEntityAlpha(ped, 255, false)
        FreezeEntityPosition(ped, true) 
        SetEntityInvincible(ped, true) 
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, v.anim, false, true)
    end
end

ShowFloatingHelpNotification = function(msg, coords)
	AddTextEntry('FloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('FloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

ShowNotification = function(msg)
    SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end
