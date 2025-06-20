local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local Topic, vocation, town, destination = {}, {}, {}, {}
local TOWN_ISLANDOFDESTINY = 16
local islandOfDestinyEnabled = false

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function greetCallback(cid)
    if getPlayerLevel(cid) < 8 then
        npcHandler:say("CHILD! COME BACK WHEN YOU HAVE GROWN UP!", cid)
        return false
    elseif getPlayerLevel(cid) > 200 then
        npcHandler:say(getCreatureName(cid) .. ", I CAN'T LET YOU LEAVE - YOU ARE TOO STRONG ALREADY! YOU CAN ONLY LEAVE WITH LEVEL 9 OR LOWER.", cid)
        return false
    else
        local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
        Topic[talkUser], vocation[talkUser], town[talkUser], destination[talkUser] = 0, 0, 0, 0
        return true
    end
end

function creatureSayCallback(cid, type, msg)
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
    if not npcHandler:isFocused(cid) then
        return false
    elseif msgcontains(msg, "yes") and Topic[talkUser] == 0 then
        npcHandler:say("IN WHICH TOWN DO YOU WANT TO LIVE: {CARLIN}, {VENORE}" .. (isPremium(cid) == TRUE and ", {THAIS}, {DARASHIA}, {ANKRAHMUN} OR {EDRON}?" or " OR {THAIS}?"), cid)
        Topic[talkUser] = 1
    elseif msgcontains(msg, "carlin") and Topic[talkUser] == 1 then
        npcHandler:say("IN CARLIN! AND WHAT PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
        Topic[talkUser] = 2
        town[talkUser] = 5
        destination[talkUser] = {x=32360, y=31782, z=7}
    elseif msgcontains(msg, "thais") and Topic[talkUser] == 1 then
        npcHandler:say("IN THAIS! AND WHAT PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
        Topic[talkUser] = 2
        town[talkUser] = 3
        destination[talkUser] = {x=32369, y=32241, z=7}
    elseif msgcontains(msg, "venore") and Topic[talkUser] == 1 then
        npcHandler:say("IN VENORE! AND WHAT PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
        Topic[talkUser] = 2
        town[talkUser] = 4
        destination[talkUser] = {x=32957, y=32076, z=7}
    elseif msgcontains(msg, "darashia") and Topic[talkUser] == 1 and isPremium(cid) then
        npcHandler:say("IN DARASHIA! AND WHAT PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
        Topic[talkUser] = 2
        town[talkUser] = 7
        destination[talkUser] = {x=33213, y=32454, z=1}
    elseif msgcontains(msg, "ankrahmun") and Topic[talkUser] == 1 and isPremium(cid) then
        npcHandler:say("IN ANKRAHMUN! AND WHAT PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
        Topic[talkUser] = 2
        town[talkUser] = 6
        destination[talkUser] = {x=33194, y=32853, z=8}
    elseif msgcontains(msg, "edron") and Topic[talkUser] == 1 and isPremium(cid) then
        npcHandler:say("IN EDRON! AND WHAT PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
        Topic[talkUser] = 2
        town[talkUser] = 9
        destination[talkUser] = {x=33217, y=31814, z=8}
    elseif msgcontains(msg, "sorcerer") and Topic[talkUser] == 2 then
        npcHandler:say("A SORCERER! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!", cid)
        Topic[talkUser] = 3
        vocation[talkUser] = 1
    elseif msgcontains(msg, "druid") and Topic[talkUser] == 2 then
        npcHandler:say("A DRUID! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!", cid)
        Topic[talkUser] = 3
        vocation[talkUser] = 2
    elseif msgcontains(msg, "paladin") and Topic[talkUser] == 2 then
        npcHandler:say("A PALADIN! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!", cid)
        Topic[talkUser] = 3
        vocation[talkUser] = 3
    elseif msgcontains(msg, "knight") and Topic[talkUser] == 2 then
        npcHandler:say("A KNIGHT! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!", cid)
        Topic[talkUser] = 3
        vocation[talkUser] = 4
    elseif msgcontains(msg, "yes") and Topic[talkUser] == 3 then
        npcHandler:say("SO BE IT!", cid)
        doPlayerSetVocation(cid, vocation[talkUser])
        doPlayerSetTown(cid, town[talkUser])
        doTeleportThing(cid, destination[talkUser])
        doSendMagicEffect(destination[talkUser], CONST_ME_TELEPORT)
        npcHandler:releaseFocus(cid)
    else
        npcHandler:say("PLEASE REPEAT YOUR CHOICE.", cid)
    end
    return true
end

npcHandler:setMessage(MESSAGE_GREET, "|PLAYERNAME|, ARE YOU PREPARED TO FACE YOUR DESTINY?")
npcHandler:setMessage(MESSAGE_WALKAWAY, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")
npcHandler:setMessage(MESSAGE_FAREWELL, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
