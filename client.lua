ESX = nil
local player, playerCoords = false, false

-- Threads
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end

    SpawnPed()
end)

Citizen.CreateThread(function()
    while true do
        player = PlayerPedId()
        playerCoords = GetEntityCoords(player)
        Citizen.Wait(1500)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sec = 1500
        for k,v in pairs(Config['Settings']) do
            local distance = #(playerCoords - vector3(v.coords.x, v.coords.y, v.coords.z))

            if distance < Config['Distance'] then
                sec = 0
                ShowFloatingHelpNotification(Config['Locales'][Config['Locale']].Text, vector3(v.coords.x, v.coords.y, v.coords.z + 1.0))
                if IsControlJustPressed(1, Config['Key']) then
                    sec = 1500
                    TriggerEvent('mtx_teleports:MenuPoints')
                end
            end
        end
        Citizen.Wait(sec)
    end
end)

-- Events
RegisterNetEvent('mtx_teleports:MenuPoints', function()
    for k,v in pairs(Config['Points']) do
        TriggerEvent('nh-context:sendMenu', {
            {
                id = v.id,
                header = v.label,
                txt = v.txt,
                params = {
                    event = 'mtx_teleports:TeleportPlayer',
                    args = {
                        ubi = v.coords,
                        name = v.label,
                    }
                }
            }
        })
    end
end)

RegisterNetEvent('mtx_teleports:TeleportPlayer')
AddEventHandler('mtx_teleports:TeleportPlayer', function(data)

    if data.ubi ~= nil then
        ESX.SetTimeout(Config['Cooldown'], function()
            SetEntityCoords(player, data.ubi.x, data.ubi.y, data.ubi.z, true, true, false, false)
            ShowNotification(Config['Locales'][Config['Locale']].Notify..data.name)
        end)
    end

end)

-- Functions
function SpawnPed()
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

function ShowFloatingHelpNotification(msg, coords)
	AddTextEntry('esxFloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

function ShowNotification(msg)
    SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end
