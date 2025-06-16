-- Including the Advanced NPC System
dofile('data/npc/lib/npcsystem/npcsystem.lua')

-- Função auxiliar para verificar se uma tabela contém um valor
function tableContains(tbl, val)
	for i = 1, #tbl do
		if tbl[i] == val then
			return true
		end
	end
	return false
end

function msgcontains(message, keyword)
	local message, keyword = message:lower(), keyword:lower()
	if message == keyword then
		return true
	end

	return message:find(keyword) and not message:find('(%w+)' .. keyword)
end

function doNpcSellItem(player, itemid, amount, subType, ignoreCap, inBackpacks, backpack)
	amount = amount or 1
	subType = subType or 0

	if type(player) == "number" then
		player = Player(player)
	end

	if not player then
		return 0, 0
	end

	local item = 0

	if ItemType(itemid):isStackable() then
		if inBackpacks then
			local container = Game.createItem(backpack, 1)
			if not container or not container:isContainer() then
				return 0, 0
			end
			item = container:addItem(itemid, math.min(100, amount))
			if player:addItemEx(container, ignoreCap) ~= RETURNVALUE_NOERROR then
				return 0, 0
			end
			return amount, 1
		else
			local stack = Game.createItem(itemid, math.min(100, amount))
			if not stack then return 0, 0 end
			if player:addItemEx(stack, ignoreCap) ~= RETURNVALUE_NOERROR then
				return 0, 0
			end
			return amount, 0
		end
	end

	local a, b = 0, 0
	if inBackpacks then
		local capacity = ItemType(backpack):getCapacity()
		local container = Game.createItem(backpack, 1)
		if not container or not container:isContainer() then
			return 0, 0
		end
		b = 1

		for i = 1, amount do
			container:addItem(itemid, subType)
			if i % capacity == 0 or i == amount then
				if player:addItemEx(container, ignoreCap) ~= RETURNVALUE_NOERROR then
					b = b - 1
					break
				end

				a = i
				if i < amount then
					container = Game.createItem(backpack, 1)
					b = b + 1
				end
			end
		end
		return a, b
	end

	for i = 1, amount do
		local item = Game.createItem(itemid, subType)
		if not item then break end
		if player:addItemEx(item, ignoreCap) ~= RETURNVALUE_NOERROR then
			break
		end
		a = i
	end
	return a, 0
end

local func = function(cid, text, type, e, pcid)
	local player = Player(pcid)
	if player then
		local creature = Creature(cid)
		if creature then
			creature:say(text, type, false, player, creature:getPosition())
		end
	end
	e.done = true
end

function doCreatureSayWithDelay(cid, text, type, delay, e, pcid)
	local player = Player(pcid)
	if player then
		e.done = false
		e.event = addEvent(func, delay < 1 and 1000 or delay, cid, text, type, e, pcid)
	end
end

function doPlayerSellItem(cid, itemid, count, cost)
	local player = Player(cid)
	if player and player:removeItem(itemid, count) then
		if not player:addMoney(cost) then
			error('Could not add money to ' .. player:getName() .. ' (' .. cost .. 'gp)')
		end
		return true
	end
	return false
end

function doPlayerBuyItemContainer(cid, containerid, itemid, count, cost, charges)
	local player = Player(cid)
	if not player or not player:removeTotalMoney(cost) then
		return false
	end

	for i = 1, count do
		local container = Game.createItem(containerid, 1)
		if not container then return false end
		for x = 1, ItemType(containerid):getCapacity() do
			container:addItem(itemid, charges)
		end
		if player:addItemEx(container, true) ~= RETURNVALUE_NOERROR then
			return false
		end
	end
	return true
end

function getCount(str)
	local b, e = str:find("%d+")
	if not b or not e then return -1 end
	local num = tonumber(str:sub(b, e))
	if num > 2^32 - 1 then
		print("Warning: Casting value to 32bit to prevent crash\n"..debug.traceback())
	end
	return math.min(2^32 - 1, num)
end

function isValidMoney(money)
	return type(money) == "number" and money > 0
end

function getMoneyCount(str)
	local b, e = str:find("%d+")
	if not b or not e then return -1 end
	local num = tonumber(str:sub(b, e))
	if num > 2^32 - 1 then
		print("Warning: Casting value to 32bit to prevent crash\n"..debug.traceback())
	end
	num = math.min(2^32 - 1, num)
	return isValidMoney(num) and num or -1
end

function getMoneyWeight(money)
	local weight, currencyItems = 0, Game.getCurrencyItems()
	for i = #currencyItems, 1, -1 do
		local currency = currencyItems[i]
		local worth = currency:getWorth()
		local count = math.floor(money / worth)
		if count > 0 then
			money = money - (count * worth)
			weight = weight + currency:getWeight(count)
		end
	end
	return weight
end
