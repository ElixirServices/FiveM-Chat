RegisterCommand("police", function(source, args, rawCommand) 
    local text = ""

    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    TwoNa.TriggerCallback("2na_chat:getCharacterInfo", source, {}, function(character) 
        if character then 
            if character.job.name == 'police' then 
                TwoNa.TriggerCallback("2na_chat:sendJobMessages", source, {
                    job = 'police', 
                    message = {
                        type = 'POLICE', header = character.name, typeColor = Config.TypeColors["police"], text = text
                    } 
                })
            else
                TriggerClientEvent("chat:addMessage", source, {
                    type = "ERROR",
                    typeColor = Config.TypeColors["error"],
                    header = "PERMISSON ERROR",
                    args = { "You don't have enough permissions to use this command!" }
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
end)

RegisterCommand("ems", function(source, args, rawCommand) 
    local text = ""

    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    TwoNa.TriggerCallback("2na_chat:getCharacterInfo", source, {}, function(character) 
        if character then 
            if character.job.name == 'ambulance' then 
                TwoNa.TriggerCallback("2na_chat:sendJobMessages", source, {
                    job = 'ambulance', 
                    message = {
                        type = 'EMS', header = character.name, typeColor = Config.TypeColors["ems"], text = text
                    } 
                })
            else
                TriggerClientEvent("chat:addMessage", source, {
                    type = "ERROR",
                    typeColor = Config.TypeColors["error"],
                    header = "PERMISSON ERROR",
                    args = { "You don't have enough permissions to use this command!" }
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
end)

RegisterCommand("grove", function(source, args, rawCommand) 
    local text = ""

    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    TwoNa.TriggerCallback("2na_chat:getCharacterInfo", source, {}, function(character) 
        if character then 
            if character.job.name == 'grove' then 
                TwoNa.TriggerCallback("2na_chat:sendJobMessages", source, {
                    job = 'grove', 
                    message = {
                        type = 'GROVE', header = character.name, typeColor = Config.TypeColors["gang"], text = text
                    } 
                })
            else
                TriggerClientEvent("chat:addMessage", source, {
                    type = "ERROR",
                    typeColor = Config.TypeColors["error"],
                    header = "PERMISSON ERROR",
                    args = { "You don't have enough permissions to use this command!" }
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
end)

RegisterCommand("ballas", function(source, args, rawCommand) 
    local text = ""

    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    TwoNa.TriggerCallback("2na_chat:getCharacterInfo", source, {}, function(character) 
        if character then 
            if character.job.name == 'ballas' then 
                TwoNa.TriggerCallback("2na_chat:sendJobMessages", source, {
                    job = 'ballas', 
                    message = {
                        type = 'GROVE', header = character.name, typeColor = Config.TypeColors["gang"], text = text
                    } 
                })
            else
                TriggerClientEvent("chat:addMessage", source, {
                    type = "ERROR",
                    typeColor = Config.TypeColors["error"],
                    header = "PERMISSON ERROR",
                    args = { "You don't have enough permissions to use this command!" }
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
end)


RegisterCommand("adminwhisper", function(source, args, rawCommand)
    local text = ""
    
    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    if IsPlayerAceAllowed(source, "command") then 
        TwoNa.TriggerCallback("2na_chat:sendAdminMessages", source, { type = "ADMIN WHISPER", typeColor = '#5d42f5', header = GetPlayerName(source), text = text  })
    else
        TriggerClientEvent("chat:addMessage", source, {
            type = "ERROR",
            typeColor = Config.TypeColors["error"],
            header = "SYSTEM ERROR",
            args = { "An error occured while trying to gather character information!" }
        })
    end
end)

RegisterCommand("announce", function(source, args, rawCommand) 
    local text = ""
    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end
    
    if IsPlayerAceAllowed(source, "command") then 
        TwoNa.TriggerCallback("2na_chat:sendAdminAnnounce", source, { type = "SYSTEM", typeColor = '#5d42f5', header = "ANNOUNCEMENT", text = text  })
    else
        TriggerClientEvent("chat:addMessage", source, {
            type = "ERROR",
            typeColor = Config.TypeColors["error"],
            header = "SYSTEM ERROR",
            args = { "An error occured while trying to gather character information!" }
        })
    end
end)

RegisterCommand("ooc", function(source, args, rawCommand) 
    local text = ""
    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    TwoNa.TriggerCallback("2na_chat:sendMessages", source, { type = 'OOC', typeColor = Config.TypeColors["ooc"], text = text })
end)

RegisterCommand("tweet", function(source, args, rawCommand) 
    local text = ""
    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    TwoNa.TriggerCallback("2na_chat:sendMessages", source, { type = 'TWEET', typeColor = Config.TypeColors["tweet"], text = text })
end)

RegisterCommand("showidentity", function(source, args, rawCommand) 
    TwoNa.TriggerCallback("2na_chat:getCharacterInfo", source, {}, function(character)
        if character then 
            TwoNa.TriggerCallback("2na_chat:showIdentity", source, {
                type = "CHARACTER INFO",
                typeColor = Config.TypeColors["charinfo"],
                header = character.name,
                text = "Gender: " .. TwoNa.Functions.Capitalize(character.gender) .. "\nDate of birth: " .. character.birth ..  "\nJob: " .. character.job.label
            })
        else
            TriggerClientEvent("chat:addMessage", source, {
                type = "ERROR",
                typeColor = '#de4949',
                header = "SYSTEM ERROR",
                args = { "An error occured while trying to gather character information." }
            })
        end
    end)
end)

RegisterCommand("yellowpages", function(source, args, rawCommand) 
    local text = ""
    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    TwoNa.TriggerCallback("2na_chat:sendYellowPages", source, { type = 'YELLOW PAGES', typeColor = Config.TypeColors["yellow_pages"], text = text })
end)

RegisterCommand("charinfo", function(source, args, rawCommand) 
    TwoNa.TriggerCallback("2na_chat:getCharacterInfo", source, {}, function(character)
        if character then 
            TriggerClientEvent("chat:addMessage", source, {
                type = "CHARACTER INFO",
                typeColor = Config.TypeColors["charinfo"],
                header = character.name,
                args = { "Gender: " .. TwoNa.Functions.Capitalize(character.gender) .. "\nDate of birth: " .. character.birth ..  "\nJob: " .. character.job.label .. '\nBank balance: ^2$' .. character.accounts.bank .. '^0\nCash amount: ^2$ ' .. character.accounts.cash}
            })
        else
            TriggerClientEvent("chat:addMessage", source, {
                type = "ERROR",
                typeColor = '#de4949',
                header = "SYSTEM ERROR",
                args = { "An error occured while trying to gather character information." }
            })
        end
    end)
end)

RegisterCommand("whisper", function(source, args, rawCommand) 
    local targetId = args[1]
    local text = ""

    for k, v in ipairs(args) do
        if k == 1 then 
        else
            text = text .. " " .. v
        end 
    end

    if tostring(source) == tostring(targetId) then 
        TriggerClientEvent("chat:addMessage", source, {
            type = "ERROR",
            typeColor = '#de4949',
            header = "SYSTEM ERROR",
            args = { "You cannot whipser to yourself!" }
        })

        return
    end

    TwoNa.TriggerCallback("2na_chat:sendWhisperMessage", source, { target = targetId, message = { type = 'WHISPER', typeColor = Config.TypeColors["whisper"], text = text } } )
end)