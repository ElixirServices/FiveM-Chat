TwoNa = exports["2na_core"]:getSharedObject()

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

TwoNa.RegisterServerCallback("2na_chat:getCommands", function(source, data, cb) 
    local commandList = {}

    for _,command in ipairs(GetRegisteredCommands()) do 
        if IsPlayerAceAllowed(source, ('command.%s'):format(command.name)) then
            table.insert(commandList, command.name)
        end
    end

    cb(commandList)
end)

TwoNa.RegisterServerCallback("2na_chat:registerRPText", function(source, data, cb) 
    local xPlayer = TwoNa.GetPlayer(source)

    if data.haveMask then 
        xPlayer.name = "Anonymous"
    end

    for _, player in ipairs(GetPlayers()) do 
        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(player))) < 10 then 
            TriggerClientEvent("2na_chat:registerRPText", player, {
                source = source,
                type = data.type,
                text = data.text,
                message = {
                    type = data.type,
                    typeColor = data.typeColor,
                    header = xPlayer.name,
                    args = { data.text }
                },
                timeout = 7000
            })    
        end
    end
end)

TwoNa.RegisterServerCallback("2na_chat:showIdentity", function(source, data, cb) 
    for _, player in ipairs(GetPlayers()) do 
        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(player))) < 3 then 
            TriggerClientEvent("chat:addMessage", player, {
                type = data.type,
                typeColor = data.typeColor,
                header = data.header,
                args = {data.text}
            })
        end
    end
end)

TwoNa.RegisterServerCallback("2na_chat:sendJobMessages", function(source, data, cb) 
    for _, playerId in ipairs(GetPlayers()) do
        local player = TwoNa.GetPlayer(tonumber(playerId))

        if player then 
            if player.job.name == data.job then 
                TriggerClientEvent("chat:addMessage", playerId, {
                    type = data.message.type,
                    typeColor = data.message.typeColor,
                    header = data.message.header,
                    args = { data.message.text }
                })
            end
        end
    end
end)

TwoNa.RegisterServerCallback("2na_chat:getCharacterInfo", function(source, data, cb) 
    local xPlayer = TwoNa.GetPlayer(source)

    cb(xPlayer)
end)

TwoNa.RegisterServerCallback("2na_chat:sendWhisperMessage", function(source, data, cb) 
    local xPlayer = TwoNa.GetPlayer(source)
    local targetPlayer = TwoNa.GetPlayer(tonumber(data.target))

    if xPlayer and targetPlayer then 
        if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(tonumber(data.target)))) < 3 then
            TriggerClientEvent("chat:addMessage", source, {
                type = data.message.type,
                typeColor = data.message.typeColor,
                header = xPlayer.name,
                args = { data.message.text }
            })
             
            TriggerClientEvent("chat:addMessage", data.target, {
                type = data.message.type,
                typeColor = data.message.typeColor,
                header = xPlayer.name,
                args = { data.message.text }
            })
        end
    else
        TriggerClientEvent("chat:addMessage", source, {
            type = "ERROR",
            typeColor = Config.TypeColors["error"],
            header = "SYSTEM ERROR",
            args = { "An error occured while trying to gather character information!" }
        })
    end
end)

TwoNa.RegisterServerCallback("2na_chat:sendMessages", function(source, data, cb) 
    local xPlayer = TwoNa.GetPlayer(source)

    if xPlayer then 
        for _,player in ipairs(GetPlayers()) do 
            TriggerClientEvent("chat:addMessage", player, {
                type = data.type,
                typeColor = data.typeColor,
                header = xPlayer.name,
                args = { data.text }
            })
        end
    end
end)


TwoNa.RegisterServerCallback("2na_chat:sendYellowPages", function(source, data, cb) 
    local xPlayer = TwoNa.GetPlayer(source)

    if xPlayer then 
        if xPlayer.getBank() >= Config.YellowPageFee then 
            xPlayer.removeBank(Config.YellowPageFee)

            for _,player in ipairs(GetPlayers()) do 
                TriggerClientEvent("chat:addMessage", player, {
                    type = data.type,
                    typeColor = data.typeColor,
                    header = xPlayer.name,
                    args = { data.text }
                })
            end
        end
    end
end)

TwoNa.RegisterServerCallback("2na_chat:sendAdminMessages", function(source, data, cb) 
    if IsPlayerAceAllowed(source, "command") then 
        for _,player in ipairs(GetPlayers()) do 
            if IsPlayerAceAllowed(player, "command") then 
                TriggerClientEvent("chat:addMessage", player, {
                    type = data.type,
                    typeColor = data.typeColor,
                    header = data.header,
                    args = { data.text }
                })
            end
        end
    end
end)

TwoNa.RegisterServerCallback("2na_chat:sendAdminAnnounce", function(source, data, cb) 
    if IsPlayerAceAllowed(source, "command") then 
        for _,player in ipairs(GetPlayers()) do 
            TriggerClientEvent("chat:addMessage", player, {
                type = data.type,
                typeColor = Config.TypeColors["announcement"],
                header = data.header,
                args = { data.text }
            })
        end
    end
end)