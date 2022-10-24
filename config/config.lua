KIDU = {};

KIDU.MarkerColor = vector3(97, 0, 224);

KIDU.EnableRespawn = true;
KIDU.RespawnDelay = 3 * 1000; -- 5 Sekunden
KIDU.ReviveTrigger = 'esx_ambulancejob:revive';
KIDU.DeathTrigger = 'esx:onPlayerDeath';

KIDU.MarkerType = 21;
KIDU.MarkerScale = vector3(0.5, 0.5, 0.5);
KIDU.MarkerColor = vector3(97, 0, 224);

KIDU.LeaveCommand = 'quitzone'; -- Set to false to disable

KIDU.Killzones = {
    {
        Entry = vector3(289.4970, -582.8468, 43.1411),
        
        Zone = {
            Coords = vector3(941.0078, -3006.8958, 5.8946),
            Color = vector3(234, 0, 255),
            Radius = 100.0,
            Opacity = 0.5,

            Spawnpoints = {
                vector3(850.2879, -2946.6084, 5.9008),
                vector3(939.8532, -2952.8057, 5.9012),
            }
        }
    },
};

KIDU.ShowHelpNotification = function(message)
    AddTextEntry('kiduHelpNotification', message);
    BeginTextCommandDisplayHelp('kiduHelpNotification');
    EndTextCommandDisplayHelp(0, false, true, -1);
end;
