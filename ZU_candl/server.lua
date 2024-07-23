local function IsPlayerAdmin(playerId)
    return IsPlayerAceAllowed(playerId, "command")
end

local notificationsEnabled = {}

local function SplitName(fullName)
    local firstName, lastName = fullName:match("(%S+)%s+(%S+)")
    if not lastName then
        firstName = fullName
        lastName = ""
    end
    return firstName, lastName
end

RegisterCommand("togglenotifs", function(source, args, rawCommand)
    if IsPlayerAdmin(source) then
        notificationsEnabled[source] = not notificationsEnabled[source]
        local status = notificationsEnabled[source] and "activées" or "désactivées"
        TriggerClientEvent('adminNotify:showNotification', source, "Les notifications ont été " .. status .. ".")
    else
        TriggerClientEvent('adminNotify:showNotification', source, "Vous n'avez pas la permission d'utiliser cette commande.")
    end
end, false)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local firstName, lastName = SplitName(name)
    local adminPlayers = GetPlayers()
    for _, playerId in ipairs(adminPlayers) do
        playerId = tonumber(playerId)
        if IsPlayerAdmin(playerId) and notificationsEnabled[playerId] then
            local connectingId = source
            TriggerClientEvent('adminNotify:playerConnecting', playerId, connectingId, firstName, lastName)
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local fullName = GetPlayerName(source)
    local firstName, lastName = SplitName(fullName)
    local droppedId = source
    local adminPlayers = GetPlayers()
    for _, playerId in ipairs(adminPlayers) do
        playerId = tonumber(playerId)
        if IsPlayerAdmin(playerId) and notificationsEnabled[playerId] then
            TriggerClientEvent('adminNotify:playerDropped', playerId, droppedId, firstName, lastName, reason)
        end
    end
    notificationsEnabled[source] = nil
end)

AddEventHandler('playerJoining', function(source)
    if IsPlayerAdmin(source) then
        notificationsEnabled[source] = true
    end
end)