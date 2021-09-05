-- Threads
Citizen.CreateThread(function()
    local config = Config['Main']

    for i = 1, #config, 1 do
        local Part = i
        local Mped = GetHashKey(config[i]['Model'])

        exports['qtarget']:AddTargetModel({Mped}, {
            options = {
                {
                    event = 'MenuPoints',
                    icon = 'fas fa-map-marked-alt',
                    label = 'Teleport '..Part,
                }
            },
            distance = Config['Distance']
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

RegisterNetEvent('onClientResourceStart')
AddEventHandler('onClientResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        SpawnPed()
    end
end)

RegisterNetEvent('onResourceStop')
AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if ped then
            DeletePed(ped)
        end
    end
end)

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

-- Functions
function SpawnPed()
    for k,v in pairs(Config['Main']) do
        RequestModel(GetHashKey(v['Model']))
        while not HasModelLoaded(GetHashKey(v['Model'])) do
            Citizen.Wait(1)
        end
    
        local x, y, z = table.unpack(v['Coords'])
        ped = CreatePed(5, GetHashKey(v['Model']), x, y, z - 1, v['Heading'], false, true)
        SetEntityAlpha(ped, 255, false)
        FreezeEntityPosition(ped, true) 
        SetEntityInvincible(ped, true) 
        SetBlockingOfNonTemporaryEvents(ped, true) 
    end
end
