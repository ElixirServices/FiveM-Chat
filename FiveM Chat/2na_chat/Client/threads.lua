Citizen.CreateThread(function() 
    while not CommandList do 
        TwoNa.TriggerServerCallback("2na_chat:getCommands", {}, function(commands)
            CommandList = commands

            for _, command in ipairs(GetRegisteredCommands()) do
                if IsAceAllowed(('command.%s'):format(command.name)) and command.name ~= 'toggleChat' then
                    table.insert(CommandList, command.name)
                end
            end
        end)

        Citizen.Wait(250)
    end
end)

Citizen.CreateThread(function() 
    while true do 
        for _, RPText in ipairs(RPTexts) do 
            local currentPed = GetPlayerPed(-1)
            local targetPed  = GetPlayerPed(GetPlayerFromServerId(RPText.source))

            local currentPedCoords = GetEntityCoords(currentPed)
            local targetPedCoords = GetEntityCoords(targetPed)

            if #(currentPedCoords - targetPedCoords) < 10 then
                local pedCoords = GetEntityCoords(targetPed)
                local multiplier = GetUserRPTExtCoordMultiplier(RPText.source, RPText.text)

                TwoNa.Draw3DText(pedCoords.x, pedCoords.y, pedCoords.z + multiplier, 0.7, RPText.text, true)
            end

        end

        Citizen.Wait(1)
    end
end)