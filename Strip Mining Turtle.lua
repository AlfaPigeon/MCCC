--Variable Declarations
local mainShaftDim = "2x2"
local sideShaftDim = "2x1"
local shaftFreq = "3"
local totalCost = 0
local input = ""
local length = 0
local currentPos = 1
local chestDist = 0
local doFuel = false



--Function Declarations
function oreDetect()
	if checkWanted() then
		print("Found something I want")

		-- Getting first block
		turtle.dig()
		turtle.forward()
		print("Got it!")

		-- Begin checking for more ore
		print("Checking for more on the right")
		turtle.turnRight()
		oreDetect()
		print("No more there")
		turtle.turnLeft()

		print("Checking for more on the left")
		turtle.turnLeft()
		oreDetect()
		print("No more there")
		turtle.turnRight()
	end

	if checkWantedUp() then
		print("There's some above me!")
		turtle.digUp()
		turtle.up()
		print("Got it!")
		print("Checking for more")

		oreDetect()
		print("No more there")
		turtle.down()
	end

	if checkWantedDown() then
		print("There's something belowe me!")
		turtle.digDown()
		turtle.down()

		print("Got it!")
		print("Checking for more")
		oreDetect()
		print("No more there")
		turtle.up()
	end

	-- Return to original spot when no more wanted ore
	print("Back to where I started")
	turtle.back()
end

-- Checks if block is a wanted material
function checkWanted()
	-- Requires stone, dirt, gravel, marble in slots 12 - 15
	wanted = false
	if turtle.detect() then



		turtle.select(12)
		if turtle.compare() == false then
			wanted = true
		end

		turtle.select(13)
		if turtle.compare() == false then
			wanted = true
		end

		turtle.select(14)
		if turtle.compare() == false then
			wanted = true
		end

		turtle.select(15)
		if turtle.compare() == false then
			wanted = true
		end
	end
	return wanted
end

function checkWantedUp()
	wanted = false

	if turtle.detectUp() then
		turtle.select(12)
		if turtle.compareUp() == false then
			wanted = true
		end

		turtle.select(13)
		if turtle.compareUp() == false then
			wanted = true
		end

		turtle.select(14)
		if turtle.compareUp() == false then
			wanted = true
		end

		turtle.select(15)
		if turtle.compareUp() == false then
			wanted = true
		end
	end
	return wanted
end

function checkWantedDown()
	wanted = false

	if turtle.detectDown() then
		turtle.select(12)
		if turtle.compareDown() == false then
			wanted = true
		end

		turtle.select(13)
		if turtle.compareDown() == false then
			wanted = true
		end

		turtle.select(14)
		if turtle.compareDown() == false then
			wanted = true
		end

		turtle.select(15)
		if turtle.compareDown() == false then
			wanted = true
		end
	end
	return wanted
end

-- Refuels the turtle with slots 1-15
function refuel()
	for i=1,15,1 do
		turtle.select(i)
		turtle.refuel(turtle.getItemCount(i))
	end
	turtle.select(1)
end

function dig()
	oreDetect()
	turtle.dig()
end

-- Mines the main 2x2 shaft of the system
function mainShaft()
	turtle.select(1)
	for i=1,4,1 do
		while turtle.detect() == true do
			dig()
		end
		turtle.forward()
		if not turtle.detectDown() then
			turtle.placeDown()
		end
		while turtle.detectUp() do
			turtle.digUp()
		end
		turtle.turnRight()
		while turtle.detect() == true do
			dig()
		end
		turtle.forward()
		if not turtle.detectDown() then
			turtle.placeDown()
		end
		while turtle.detectUp() do
			turtle.digUp()
		end
		turtle.turnRight()
		turtle.turnRight()
		while turtle.detect() do
			dig()
		end
		turtle.forward()
		if not turtle.detectDown() then
			turtle.placeDown()
		end
		turtle.turnRight()
	end
	turtle.turnRight()
	turtle.turnRight()
	turtle.select(16)
	turtle.forward()
	turtle.placeUp()
	turtle.turnLeft()
	turtle.forward()
	turtle.placeUp()
	turtle.turnLeft()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.turnRight()
end

-- Mines a 2x1 side shaft off of the main shaft of the system
function sideShaft()
	turtle.select(1)
	for i=0,10,1 do
		while turtle.detect() == true do
			dig()
		end
		turtle.forward()
		if turtle.detectDown() == false then
			turtle.placeDown()
		end
		while turtle.detectUp() == true do
			turtle.digUp()
		end
	end
	turtle.select(16)
	turtle.turnRight()
	turtle.turnRight()
	turtle.place()
	turtle.turnRight()
	turtle.turnRight()
	turtle.select(1)
	for i=0,10,1 do
		while turtle.detect() == true do
			dig()
		end
		turtle.forward()
		if turtle.detectDown() == false then
			turtle.placeDown()
		end
		while turtle.detectUp() == true do
			turtle.digUp()
		end
	end
	turtle.turnRight()
	turtle.turnRight()
	turtle.select(16)
	turtle.place()
	turtle.up()
	for i=1,23,1 do
		while turtle.detect() do
			dig()
		end
		turtle.forward()
	end
	turtle.down()
end


-- Places all the goodies in the designated chest
function deposit()
	for i=1, (chestDist), 1 do
		turtle.forward()
	end
	for i=1, 11, 1 do
		turtle.select(i)
		turtle.drop()
	end
	refuel()
	if turtle.getItemCount(16) < 6 then
		stopMining()
	end
	if turtle.getFuelLevel() < (108 + 2 * chestDist) then
		stopMining()
	end
	turtle.turnRight()
	turtle.turnRight()
	for i=1, (chestDist), 1 do
		turtle.forward()
	end

end

-- Stops mining for some reason or another
function stopMining()
	if turtle.getFuelLevel() < (108 + 2 * chestDist) then
		print("I am low on fuel.")
		local remainFuel = 0
		for i=currentPos, length, 1 do
			remainFuel = (108 + 2 * (4 * i + 1))
		end
		print("I need "..remainFuel.." to finish.")
		print("That's "..(remainFuel/80).." coal or "..(remainFuel/1000).." lava.")
		print("Type (cont) to refuel & continue mining.")
		doFuel = true
	end
	if turtle.getItemCount(16) < 6 then
		print("I am low on torches.")
		print("Place more in slot 9...")
		while turtle.getItemCount(16) < 6 do
			sleep(1)
		end
		print("Type (cont) to continue mining.")
		doFuel = false
	end
	local cont = false
	while cont == false do
		--[[
		if rs.getInput("right") == true then --Flickers RS torch on right of chest
			rs.setOutput("right", false)
		else
			rs.setOutput("right", true)
		end
		]]
		local input = io.read()
		if input == "cont" then

			if doFuel then
				refuel()
			end

			turtle.turnRight()
			turtle.turnRight()
			for i=1, chestDist, 1 do
				turtle.forward()
			end
			currentPos = currentPos + 1
			run()
		else
			print("Incorrect input.")
		end
	end
end

-- Run the mining loop
function run()
	while currentPos < length do
		chestDist = (currentPos * 4 + 4)
		mainShaft()
		turtle.turnLeft()
		sideShaft()
		sideShaft()
		turtle.turnLeft()
		deposit()
		currentPos = currentPos + 1
	end
end

-- Alert system for user, using the redstone torch
function idle()
	print("Mining Complete")
	print("Type (end) to terminate program")
	local input = "null"
	rs.setOutput("right", true)
	while input ~= "end" do
		input = io.read()
	end
	rs.setOutput("right", false)
end

--Execution
print("----------------------------------")
print("Branch Mine Turtle Activated")
print("----------------------------------")
sleep(2)
print("Beginning Mine w. Following Specs:")
print("Main Shaft: "..mainShaftDim)
print("Side Shafts: "..sideShaftDim)
print("Branch Frequency: "..shaftFreq)
print("----------------------------------")

print("Number of Shafts:")
length = tonumber(read())
currentPos = 0
print("----------------------------------")

for x = length, 0, -1 do
	totalCost = totalCost + (108 + 2 * (4 * x + 1))
end


print("Current Fuel: "..turtle.getFuelLevel())
print("Fuel cost: "..totalCost)
print("Coal cost: "..(totalCost/80))
print("Lava cost: "..(totalCost/1000))
sleep(2)
print("----------------------------------")
print("Would you like to refuel now (y/n)?")
input = io.read()
if input == "y" then
	refuel()
	print("Refueled.")
else
	print("Did not refuel.")
end
print("Turtle now has "..turtle.getFuelLevel().." fuel.")
print("----------------------------------")

print("Now beginning mining!")

run()
turtle.turnRight()
turtle.turnRight()
for i=1, chestDist, 1 do
	turtle.forward()
end
idle()