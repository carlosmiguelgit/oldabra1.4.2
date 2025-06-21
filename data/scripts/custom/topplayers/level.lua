local checkInterval = 10 -- seconds

local topPlayers = {
    {name = "", level = 0, monsterId = 0, position = Position(32368, 32243, 7)},
    {name = "", level = 0, monsterId = 0, position = Position(32370, 32243, 7)},
    {name = "", level = 0, monsterId = 0, position = Position(32372, 32243, 7)}
}

local function setMonsterDefaultSettings(monster)
    monster:rename("Top Player [LvL: ??]", "a top online placeholder creature")
    local outfit = monster:getOutfit()
    outfit.lookType = 0
    outfit.lookTypeEx = 2110
    monster:setOutfit(outfit)
    monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
end

local function createTopScoreMonster(index)
    local monster = Game.createMonster("deer", topPlayers[index].position, false, true)
    monster:setDropLoot(false)
    topPlayers[index].monsterId = monster:getId()
    setMonsterDefaultSettings(monster)
    return monster
end

local function getTopPlayersFromDatabase()
    local limit = #topPlayers
    local resultId = db.storeQuery("SELECT `name`, `level` FROM `players` WHERE `group_id` < 2 ORDER BY `level` DESC LIMIT " .. limit .. ";")
    if not resultId then return end

    local index = 1
    repeat
        local name = result.getDataString(resultId, "name")
        local level = result.getDataInt(resultId, "level")

        if name and level then
            topPlayers[index].name = name
            topPlayers[index].level = level
        else
            topPlayers[index].name = "Unknown"
            topPlayers[index].level = 0
        end

        index = index + 1
    until not result.next(resultId) or index > limit

    result.free(resultId)
end

local globalevent = GlobalEvent("onThink_showTopPlayers")

function globalevent.onThink(interval)
    getTopPlayersFromDatabase()

    for i, data in ipairs(topPlayers) do
        local monster = Monster(data.monsterId)

        if not monster or not monster:isMonster() then
            monster = createTopScoreMonster(i)
        end

        local player = Player(data.name)
        if player and player:getPosition() == data.position then
            monster:remove()
            topPlayers[i].monsterId = 0
        else
            local safeLevel = tonumber(data.level) or 0
            local newName = string.format("%s [LvL: %d]", data.name, safeLevel)
            monster:rename(newName, "Top #" .. i)
            monster:setOutfit({lookType = 130}) -- personalize o lookType aqui
            monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        end
    end

    return true
end

globalevent:interval(checkInterval * 1000)
globalevent:register()

local startupEvent = GlobalEvent("onStartup_showTopPlayers")
function startupEvent.onStartup()
    for k = 1, #topPlayers do
        createTopScoreMonster(k)
    end
    return true
end
startupEvent:register()
