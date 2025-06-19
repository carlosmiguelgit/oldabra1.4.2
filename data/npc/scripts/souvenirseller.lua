local keywordHandler = KeywordHandler:new() 
local npcHandler = NpcHandler:new(keywordHandler) 
NpcSystem.parseParameters(npcHandler) 
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end 
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end 
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end 
function onThink() npcHandler:onThink() end 
function creatureSayCallback(cid, type, msg) 
if(not npcHandler:isFocused(cid)) then 
return false 
end 
local talkState = {}
local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
local shopWindow = {}
local moeda = 8351 -- id da sua moeda vip
local t = {

[8310] = {price = 10},
[8312] = {price = 10},
[1991] = {price = 10},
[1992] = {price = 10},
[1993] = {price = 10},
[1994] = {price = 10},
[1995] = {price = 10},
[1996] = {price = 10},
[1997] = {price = 10},
[1998] = {price = 10},
[1999] = {price = 10},
[2000] = {price = 10},
[2001] = {price = 10},
[2002] = {price = 10},
[2003] = {price = 10},
[2004] = {price = 10},
[8307] = {price = 10},
[8309] = {price = 10},
[8311] = {price = 10},
[8313] = {price = 10},
[8316] = {price = 10},
[8321] = {price = 10},
[5819] = {price = 10},
[3939] = {price = 10},
[3940] = {price = 10},
[3960] = {price = 10},
[5785] = {price = 10},
[5786] = {price = 10},
[5787] = {price = 10},
[5788] = {price = 10},
[5789] = {price = 10},
[8405] = {price = 10},
[8406] = {price = 10},
[8407] = {price = 10},
[8408] = {price = 10},
[8409] = {price = 10},
[8410] = {price = 10},
[8411] = {price = 10},
[8412] = {price = 30}
  
}
      
local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
    if  t[item] and not doPlayerRemoveItem(cid, moeda, t[item].price) then
          selfSay("You don't have "..t[item].price.." "..getItemNameById(moeda), cid)
             else
        doPlayerAddItem(cid, item)
        selfSay("Here are you.", cid)
       end
    return true
end
if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
            for var, ret in pairs(t) do
                    table.insert(shopWindow, {id = var, subType = 0, buy = ret.price, sell = 0, name = getItemNameById(var)})
                end
            openShopWindow(cid, shopWindow, onBuy, onSell)
            end
return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback) 
npcHandler:addModule(FocusModule:new())