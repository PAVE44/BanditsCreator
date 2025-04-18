--
-- ********************************
-- *** Bandits Creator          ***
-- ********************************
-- *** Coded by: Slayer         ***
-- ********************************
--

BCMenu = BCMenu or {}

function BCMenu.BanditCreator(player)
    local modal = BanditClansMain:new(500, 80, 1220, 900)
    modal:initialise()
    modal:addToUIManager()
end

function BCMenu.SpawnClan(player, square, cid)
    local args = {}
    args.cid = cid
    args.x = square:getX()
    args.y = square:getY()
    args.z = square:getZ()
    sendClientCommand(player, 'Spawner', 'Type', args)
end

function BCMenu.WorldContextMenuPre(playerID, context, worldobjects, test)
    local player = getSpecificPlayer(playerID)
    local square = BanditCompatibility.GetClickedSquare()

    if isDebugEnabled() or isAdmin() then
        context:addOption("Bandit Creator", player, BCMenu.BanditCreator)

        BanditCustom.Load()
        local clanData  = BanditCustom.ClanGetAllSorted()
        local clanSpawnOption = context:addOption("Spawn Bandit Clan")
        local clanSpawnMenu = context:getNew(context)
        context:addSubMenu(clanSpawnOption, clanSpawnMenu)
        for cid, clan in pairs(clanData) do
            clanSpawnMenu:addOption("Clan " .. clan.general.name, player, BCMenu.SpawnClan, square, cid)
        end
    end

    
end

Events.OnPreFillWorldObjectContextMenu.Add(BCMenu.WorldContextMenuPre)