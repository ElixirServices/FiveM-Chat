RegisterKeyMapping("+chat", "Show chat", "KEYBOARD", Config.ShowChatKey)
RegisterCommand("+chat", function() 
    TriggerEvent("chat:show")
end)

RegisterCommand("me", function(source, args, rawCommand) 
    local text = ""
    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    local haveMask = false
    if GetPedDrawableVariation(GetPlayerPed(-1), 1) == 0 then
        haveMask = false
    else
        haveMask = true
    end

    TwoNa.TriggerServerCallback("2na_chat:registerRPText", { type = 'ME', typeColor = Config.TypeColors["me"], haveMask = haveMask, text = text })
end)

RegisterCommand("do", function(source, args, rawCommand) 
    local text = ""
    for _,v in ipairs(args) do 
        text = text .. " " .. v
    end

    if text:len() == 0 then 
        return
    end

    local haveMask = false
    if GetPedDrawableVariation(GetPlayerPed(-1), 1) == 0 then
        haveMask = false
    else
        haveMask = true
    end

    TwoNa.TriggerServerCallback("2na_chat:registerRPText", { type = 'DO', typeColor = Config.TypeColors["do"], haveMask = haveMask, text = text })
end)