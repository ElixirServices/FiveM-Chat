TwoNa = exports["2na_core"]:getSharedObject()
RPTexts = {}
CommandList = nil

RegisterNetEvent('chat:addMode')
RegisterNetEvent('chat:removeMode')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('__cfx_internal:serverPrint')
RegisterNetEvent('_chat:messageEntered')

RegisterNetEvent("chat:show")
AddEventHandler("chat:show", function()
    SetNuiFocus(true, true)

    SendNUIMessage({
        action  = "showChat",
        commandList = CommandList or {},
        defaultSuggestions = Config.DefaultSuggestions,
        enableEmojiMenu = Config.EnableEmojiMenu,
        oocMessageWithoutCommand = Config.OOCMessageWithoutCommand
    })
end)

RegisterNetEvent("chat:hide")
AddEventHandler("chat:hide", function() 
    SendNUIMessage({
        action  = "hideChat"
    })

    SetNuiFocus(false, false)
end)

RegisterNetEvent('chat:addMessage')
AddEventHandler("chat:addMessage", function(data) 
    SendNUIMessage({
        action  = "addMessage",
        message = data
    })
end)

RegisterNetEvent('chat:addSuggestion')
AddEventHandler("chat:addSuggestion", function(command, help, params)
    SendNUIMessage({
        action  = "addSuggestion",
        command = string.gsub(command, '/', ''),
        description = help,
        args = params
    })
end)

RegisterNetEvent('chat:addSuggestions')
AddEventHandler("chat:addSuggestions", function(suggestions) 
    for k,v in ipairs(suggestions) do 
        SendNUIMessage({
            action  = "addSuggestion",
            command = string.gsub(v.name, '/', ''),
            description = v.help,
            args = v.params
        })
    end
end)

RegisterNetEvent('chat:addTemplate')
AddEventHandler("chat:addTemplate", function(data) 
    SendNUIMessage({

    })
end)

RegisterNetEvent('chat:clear')
AddEventHandler("chat:clear", function(data) 
    SendNUIMessage({
        action = "clear"
    })
end)

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }

  if author ~= "" then
    table.insert(args, 1, author)
  end

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = color,
      multiline = true,
      args = args
    }
  })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  SendNUIMessage({
    action = 'addMessage',
    message = {
      templateId = 'print',
      multiline = true,
      args = { msg },
      mode = '_global'
    }
  })
end)

RegisterNetEvent("2na_chat:registerRPText")
AddEventHandler("2na_chat:registerRPText", function(data) 
    TriggerEvent("chat:addMessage", data.message)
    
    table.insert(RPTexts, data)

    Citizen.Wait(data.timeout)

    for k,v in ipairs(RPTexts) do 
        if v.text == data.text and v.source == data.source then 
            table.remove(RPTexts, k)
        end
    end
end)