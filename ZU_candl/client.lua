local function ShowNotification(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(true, false)
end

RegisterNetEvent('adminNotify:playerConnecting')
AddEventHandler('adminNotify:playerConnecting', function(playerId, firstName, lastName)
    local message = string.format("~g~Connexion~w~\nID: %d\nPrénom: %s\nNom: %s", playerId, firstName, lastName)
    ShowNotification(message)
end)

RegisterNetEvent('adminNotify:playerDropped')
AddEventHandler('adminNotify:playerDropped', function(playerId, firstName, lastName, reason)
    local message = string.format("~r~Déconnexion~w~\nID: %d\nPrénom: %s\nNom: %s\nRaison: %s", playerId, firstName, lastName, reason)
    ShowNotification(message)
end)

RegisterNetEvent('adminNotify:showNotification')
AddEventHandler('adminNotify:showNotification', function(message)
    ShowNotification(message)
end)