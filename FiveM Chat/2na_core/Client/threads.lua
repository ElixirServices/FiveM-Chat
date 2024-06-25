Citizen.CreateThread(function() 
    while TwoNa.Framework == nil do
        if Config.Framework == 'ESX' then
            TwoNa.Framework = exports["es_extended"]:getSharedObject()
        else if Config.Framework == 'QB' then
                TwoNa.Framework = exports["qb-core"]:GetCoreObject()
            end
        end

        Citizen.Wait(1)
    end
end)