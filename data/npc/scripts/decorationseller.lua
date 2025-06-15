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

[8172] = {price = 2},
[8181] = {price = 2},
[3901] = {price = 2},
[3902] = {price = 2},
[3903] = {price = 2},
[3904] = {price = 2},
[3905] = {price = 2},
[3906] = {price = 2},
[3907] = {price = 2},
[3908] = {price = 2},
[3909] = {price = 2},
[3910] = {price = 2},
[3911] = {price = 2},
[3912] = {price = 2},
[3913] = {price = 2},
[3914] = {price = 2},
[3915] = {price = 2},
[3916] = {price = 2},
[3917] = {price = 2},
[3918] = {price = 2},
[3919] = {price = 2},
[3920] = {price = 2},
[3921] = {price = 2},
[3922] = {price = 2},
[3923] = {price = 2},
[3924] = {price = 2},
[3925] = {price = 2},
[3926] = {price = 2},
[3927] = {price = 2},
[3928] = {price = 2},
[3929] = {price = 2},
[3930] = {price = 2},
[8185] = {price = 2},
[8186] = {price = 2},
[3931] = {price = 2},
[3932] = {price = 2},
[3933] = {price = 2},
[3934] = {price = 2},
[3935] = {price = 2},
[3936] = {price = 2},
[3937] = {price = 2},

[8199] = {price = 3},
[8179] = {price = 3},
[8200] = {price = 3},
[8202] = {price = 3},
[8218] = {price = 3},
[8220] = {price = 3},

[8216] = {price = 3},
[8228] = {price = 3},
[8296] = {price = 3},
[8172] = {price = 5},
[8185] = {price = 10},
[8186] = {price = 10},
[8193] = {price = 10},

[3938] = {price = 2}	
  
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