function GetUserRPTExtCoordMultiplier(source, text)
    local currentIndex = 0

    for k,v in ipairs(RPTexts) do 
        if v.source == source and v.text == text then 
            currentIndex = k
        end
    end

    return (currentIndex - 1) / 10
end