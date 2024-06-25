RegisterNuiCallback("hide", function() 
    TriggerEvent("chat:hide")
end)

RegisterNuiCallback("processInput", function(data)
    ExecuteCommand(data.command) 
end)