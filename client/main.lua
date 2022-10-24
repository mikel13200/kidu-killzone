local currentZone = nil;
local isNearEntry = false;

Citizen.CreateThread(function()
    if KIDU.EnableRespawn then
        RegisterNetEvent(KIDU.DeathTrigger)
        AddEventHandler(KIDU.DeathTrigger, function()
            Citizen.Wait(KIDU.RespawnDelay);
            
            if currentZone then
                SetEntityCoords(PlayerPedId(), currentZone.Zone.Spawnpoints[math.random(1, #currentZone.Zone.Spawnpoints)]);
                TriggerEvent(KIDU.ReviveTrigger);
            end
        end);
    end

    while true do
        Citizen.Wait(0);

        local playerPed = PlayerPedId();
        local playerCoords = GetEntityCoords(playerPed, true);

        if not currentZone then
            for i = 1, #KIDU.Killzones do
                local currentItem = KIDU.Killzones[i];
                
                if GetDistanceBetweenCoords(playerCoords, currentItem.Zone.Coords, true) < currentItem.Zone.Radius + 50.0 then
                    currentZone = currentItem;
                end
                
                if GetDistanceBetweenCoords(playerCoords, currentItem.Entry, true) < 6.0 then
                    currentZone = currentItem;
                    isNearEntry = true;
                end
            end
        end
        
        if currentZone and not isNearEntry then
            DrawSphere(currentZone.Zone.Coords, currentZone.Zone.Radius, currentZone.Zone.Color, currentZone.Zone.Opacity);            
            
            if GetDistanceBetweenCoords(playerCoords, currentZone.Zone.Coords, true) > currentZone.Zone.Radius + 50.0 then
                currentZone = nil;
            end
        elseif currentZone and isNearEntry then
            if GetDistanceBetweenCoords(playerCoords, currentZone.Entry, true) > 6.0 then
                currentZone = nil;
                isNearEntry = false;
            else
                DrawMarker(KIDU.MarkerType, currentZone.Entry, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, KIDU.MarkerScale, KIDU.MarkerColor, 75, true, true, 2, false, nil, nil, false);
                KIDU.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um die Killzone zu betreten.');
    
                if IsControlJustPressed(0, 51) then
                    isNearEntry = false;
                    DoScreenFadeOut(500);
                    
                    while not IsScreenFadedOut() do
                        Citizen.Wait(0);
                    end
                    
                    SetEntityCoords(playerPed, currentZone.Zone.Spawnpoints[math.random(1, #currentZone.Zone.Spawnpoints)]);
                    DoScreenFadeIn(500);
                end
            end
        end

        if not currentZone then
            Citizen.Wait(500);
        end
    end
end);

if KIDU.LeaveCommand then
    RegisterCommand(KIDU.LeaveCommand, function()
        if currentZone then
            SetEntityCoords(PlayerPedId(), currentZone.Entry); 
        end
    end, false);
end