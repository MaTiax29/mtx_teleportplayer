RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLogout') 
AddEventHandler('esx:playerLogout', function(xPlayer, isNew)
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

AddEventHandler('onClientResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        SpawnPed()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if ped then
            DeletePed(ped)
        end
    end
end)

-- ########### -- 

-- Threads
Citizen.CreateThread(function()
    for k,v in pairs(Config['Main']) do
        exports['qtarget']:AddBoxZone('Teleport - '..k, v['Coords'], 0.6, 0.6, {
            name = v['Label'],
            heading = v['Heading'],
            debugPoly = false,
            minZ = v['ZCoords']['min'],
            maxZ = v['ZCoords']['max'],
        }, {
            options = {
                {
                    event = 'MenuPoints',
                    icon = Config['Icon'],
                    label = v['Label']
                }
            },
            distance = Config['Distance'],
        })
    end
end)

-- Events
RegisterNetEvent('MenuPoints') 
AddEventHandler('MenuPoints', function(data)
    local MenuZ = {}
    for k,v in pairs(Config['Zones']) do
        table.insert(MenuZ, {
            id = k,
            header = v['Label'],
            txt = v['Desc'],
            params = {
                event = 'TeleportPlayer',
                args = {
                    zone = v['Label'],
                    coords = v['Coords']
                }
            }
        })
    end
    TriggerEvent('nh-context:sendMenu', MenuZ)
end)

RegisterNetEvent('TeleportPlayer') 
AddEventHandler('TeleportPlayer', function(data)
    if data.coords ~= nil then
        SetEntityCoords(PlayerPedId(), data.coords.x, data.coords.y, data.coords.z, true, false, false, false)
    end
end)

-- Functions
function SpawnPed()
    for k,v in pairs(Config['Main']) do
        RequestModel(GetHashKey(v['Model']))
        while not HasModelLoaded(GetHashKey(v['Model'])) do
            Citizen.Wait(1)
        end
    
        ped = CreatePed(5, GetHashKey(v['Model']), v['Coords'], v['Heading'], false, true)
        SetEntityAlpha(ped, 255, false)
        FreezeEntityPosition(ped, true) 
        SetEntityInvincible(ped, true) 
        SetBlockingOfNonTemporaryEvents(ped, true) 
    end
end
