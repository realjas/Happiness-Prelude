local Missions = {}

function Missions:Init()
	local missions = {}
	missions.objectives = {
		"Explore the world and see what you find!",

		"I could Build an AXE with this stick and a rock.",
		"Sweet!  Now I can build myself an axe.",
		"With this Axe I can chop down trees to gather wood for a house.",

		"I should build a hammer to smash some of these rocks for gems",
		"Let's see how many gems are hidden in this place.",

		"I should gather enough materials to build shelter for the night.",
		"I can build a house now!",
		"There's not much left to do... I should go homoe and sleep.",
		"Good night, sweet world."
	}
	missions.phase = 0

	function missions.load()
		missions.newMission = love.audio.newSource('assets/sounds/new_mission.wav')
		missions.build = love.audio.newSource('assets/sounds/build.wav')
	end

	function missions.update()
		if wood == -1 and rock == -1 and missions.phase == 0 then
			--explore
			missions.phase = 1
			phaseChange(missions.phase)
		elseif (wood == 1 or rock == 1) and missions.phase == 1 then
			--build axe when requirement met
			missions.phase = 2
			phaseChange(missions.phase)
		elseif wood ==1 and rock == 1 and missions.phase == 2 then
			--mission: build axe
			missions.phase = 3
			phaseChange(missions.phase)
			build = 1
		elseif hasAxe == false and missions.phase == 3 then
			--actual: build axe
			if love.mouse.isDown(1) or love.keyboard.isDown( "space" ) then
				wood = wood - 1
				rock = rock - 1
				hasAxe = true
				phaseChange(missions.phase)
			end
		elseif hasAxe == true and missions.phase == 3 then
			--use axe to cut down trees
			missions.phase = 4
			build = 0
			phaseChange(missions.phase)
		elseif hasHammer == false and wood >= 1 and rock >= 1 and missions.phase == 4 and math.floor(heroX/map1tileWidth) >= 100 then
			--mission: build hammer
			missions.phase = 5
			build = 2
			phaseChange(missions.phase)
		elseif hasHammer == false and missions.phase == 5 and math.floor(heroX/map1tileWidth) >= 100 then
			--actual: build hammer
			if love.mouse.isDown(1) or love.keyboard.isDown( "space" ) then
				wood = wood - 1
				rock = rock - 1
				hasHammer = true
				phaseChange(missions.phase)
			end
		elseif hasHammer == true and missions.phase == 5 and math.floor(heroX/map1tileWidth) >= 100 then
			--smash rocks for gems
			missions.phase = 6
			build = 0
			phaseChange(missions.phase)
		elseif missions.phase == 6 and math.floor(heroX/map1tileWidth) <= 100 then
			missions.phase = 7
			phaseChange(missions.phase)
		elseif missions.phase == 7 and rock >= 30 and wood >= 30 then
			--mission: build house
			missions.phase = 8
			phaseChange(missions.phase)
		elseif missions.phase == 8 and math.floor(heroX/map1tileWidth) == 46 and math.floor(heroY/map1tileHeight) == 33 then
			build = 3
			--actual: build house
			if love.mouse.isDown(1) or love.keyboard.isDown( "space" ) then
				wood = wood - 40
				rock = rock - 40
				map1[math.floor(heroY/map1tileHeight)-1][math.floor(heroX/map1tileWidth)] = 6
				map1[math.floor(heroY/map1tileHeight)][math.floor(heroX/map1tileWidth)] = 6
				map1[math.floor(heroY/map1tileHeight)-1][math.floor(heroX/map1tileWidth)-1] = 2
				--map1[math.floor(heroY/map1tileHeight)-2][math.floor(heroX/map1tileWidth)] = 2
				map1[math.floor(heroY/map1tileHeight)-1][math.floor(heroX/map1tileWidth)+1] = 2
				map1[math.floor(heroY/map1tileHeight)-2][math.floor(heroX/map1tileWidth)-1] = 2
				map1[math.floor(heroY/map1tileHeight)-2][math.floor(heroX/map1tileWidth)] = 2
				map1[math.floor(heroY/map1tileHeight)-2][math.floor(heroX/map1tileWidth)+1] = 2
				build = 0
				hasHouse = true
				missions.phase = 9
				phaseChange(missions.phase)
			end
		elseif missions.phase == 9 and math.floor(heroY/map1tileHeight) == 32 and math.floor(heroX/map1tileWidth) == 46 then
			--ending
			gameState = "ending"
		end
	end

	function phaseChange(phase)
		currentMission = missions.objectives[phase]
		interface:resetNewMission()
		if phase == 3 and hasAxe == true then
			missions.build:play()
		elseif phase == 4 and hasHammer == true then
			missions.newMission:play()
		else
			missions.newMission:play()
		end
	end

	function missions.draw()
		--love.graphics.print("Phase  = " .. missions.phase .. ", " .. wood .. ", " .. rock,10,10)
	end

	return missions
end

return Missions