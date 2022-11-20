--Variable Delcarations
local startY = 0
local endY = 0
local currentY = 0
local input = ""

--Function Declarations
function staircase()
	while currentY > endY do
		turtle.select(1)
		while turtle.detect() == true do
			turtle.dig()
		end
		turtle.forward()
		turtle.digUp()
		turtle.digDown()
		turtle.down()
		if not turtle.detectDown() then
			turtle.placeDown()
		end
		if (startY - currentY) % 5 == 0 then
			turtle.select(16)
			turtle.up()
			turtle.turnRight()
			turtle.turnRight()
			turtle.place()
			turtle.turnRight()
			turtle.turnRight()
			turtle.down()
		end
		currentY = currentY - 1
	end
end

function clearRoom()
	while turtle.detect() == true do
		turtle.dig()
	end
	turtle.turnLeft()
	for i=1,3,1 do
		while turtle.detect() == true do
			turtle.dig()
		end
	end
	turtle.forward()
	turtle.digUp()
	turtle.turnRight()
	for i=1,2,1 do
		for j=1,5,1 do
			while turtle.detect() == true do
				turtle.dig()
			end
			turtle.forward()
			turtle.digUp()
		end
		turtle.turnRight()
		while turtle.detect() == true do
			turtle.dig()
		end
		turtle.forward()
		turtle.digUp()
		turtle.turnRight()
		for j=1,5,1 do
			while turtle.detect() == true do
				turtle.dig()
			end
			turtle.forward()
			turtle.digUp()
		end
		turtle.turnLeft()
		while turtle.detect() == true do
			turtle.dig()
		end
		turtle.forward()
		turtle.digUp()
		turtle.turnLeft()
	end
end

function setup()
	--Double Chests
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.turnRight()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.select(15)
	turtle.place()
	turtle.turnRight()
	turtle.forward()
	turtle.turnLeft()
	turtle.place()
	turtle.turnRight()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	--Redstone Idle System
	turtle.select(1)
	turtle.place()
	turtle.up()
	turtle.select(14)
	turtle.forward()
	turtle.dig()
	turtle.back()
	turtle.place()
	turtle.down()
	--Depositing items
	turtle.turnLeft()
	for i=1,15,1 do
		turtle.select(i)
		turtle.drop(turtle.getItemCount(i))
	end
	turtle.select(1)
	turtle.turnRight()
	turtle.turnRight()
end

function run()
	staircase()
	clearRoom()
	setup()
end

--Execution
print("---------------------------------")
print("Welcome to the Strip Prep Program")
print("---------------------------------")
print("> Fill slot 16 with torches")
print("> Fill slot 15 with 1-2 chest(s)")
print("> Fill slot 14 with 1 rs torch")
sleep(5)
print("---------------------------------")
print("Please input current Y-Pos:")
startY = tonumber(read())
currentY = startY
print("Please input end Y-Pos:")
endY = tonumber(read())
print("")
print("Current Fuel Level:")
print(turtle.getFuelLevel())
print("Would you like to refuel (y/n)?")
input = io.read()
if input == "y" then
	print("Refueling all of Slot 1 in 5s")
	sleep(5)
	turtle.select(1)
	turtle.refuel(turtle.getItemCount(1))
else
	print("Did not refuel.")
end
print("Beginning Dig!")
run()
print("Ready to Strip Mine!")