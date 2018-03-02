local Interface = {}

function Interface:Init()
	local interface = {}
	interface.newMissionOpacity = 455

	function interface.load()
		interface.gem = love.graphics.newImage('assets/images/interface/gemInt.png')
		interface.wood = love.graphics.newImage('assets/images/interface/woodInt.png')
		interface.axe = love.graphics.newImage('assets/images/interface/axeInt.png')
		interface.hammer = love.graphics.newImage('assets/images/interface/hammerInt.png')
		interface.newMission = love.graphics.newImage('assets/images/interface/new_mission.png')
		interface.mission = love.graphics.newImage('assets/images/interface/missionInt.png')

		--interface.buildAxe = love.graphics.newImage('assets/images/interface/axeInt.png')
		--interface.buildHammer = love.graphics.newImage('assets/images/interface/hammerInt.png')

		interface.font = love.graphics.newFont("assets/fonts/LintMcCreeBB.ttf", 25)
		interface.score = love.graphics.newFont("assets/fonts/LintMcCreeBB.ttf", 45)
		interface.timer = 0
		interface.resplice = 1
		interface.currentMission = ""
		interface.addWord = love.audio.newSource('assets/sounds/typewriter.wav')
	end

	function interface.update()
		--new mission code
		if interface.newMissionOpacity == 455 then
			interface.str = currentMission
			interface.tbl = interface.str:explode(" ")
			interface.currentMission = ""
			interface.resplice = 0
		end
		interface.timer = interface.timer + 1
		if interface.timer == 8 then
			interface.timer = 0
			if interface.resplice <= table.getn(interface.tbl) then
				interface.currentMission = ""
				interface.addWord:play()
			end
			for i = 1, interface.resplice do
				if interface.resplice > table.getn(interface.tbl) then
					break
				end

				interface.currentMission = interface.currentMission .. " " .. interface.tbl[i]
			end

			interface.resplice = interface.resplice + 1
		end

		if interface.newMissionOpacity >= 0 then
			interface.newMissionOpacity = interface.newMissionOpacity - 2
		end
	end

	function interface.resetNewMission()
		interface.newMissionOpacity = 455
	end

	function interface.draw()
		--score
		if gems >= 0 then
			love.graphics.draw(interface.gem, 1100, 100)

			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.setFont(interface.score)
			if gems == 0 then 
				love.graphics.printf("0", 1280-50, 125, 40, "left")
			elseif gems > 0 then
				love.graphics.printf(gems, 1280-50, 125, 40, "left")
			end
			love.graphics.setColor(255, 255, 255, 255)
		end

		if wood >= 0 then
			love.graphics.draw(interface.wood, 1100, 217)

			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.setFont(interface.score)
			if wood == 0 then 
				love.graphics.printf("o", 1280-50, 240, 40, "left")
			elseif wood > 0 then
				love.graphics.printf(wood, 1280-50, 240, 40, "left")
			end
			love.graphics.setColor(255, 255, 255, 255)
		end

		if rock >= 0 and hasAxe == false and hasHammer == false then
			love.graphics.draw(interface.wood, 1100, 334)

			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.setFont(interface.score)
			if rock == 0 then 
				love.graphics.printf("o", 1280-50, 375, 40, "left")
			elseif rock > 0 then
				love.graphics.printf(rock, 1280-50, 375, 40, "left")
			end
			love.graphics.setColor(255, 255, 255, 255)
		end

		--tools
		if hasAxe then
			love.graphics.setColor(255, 255, 255, axeUsable)
			love.graphics.draw(interface.axe, 22, 650)
			love.graphics.setColor(255, 255, 255, 255)
		end

		if hasHammer then
			love.graphics.setColor(255, 255, 255, hammerUsable)
			love.graphics.draw(interface.hammer, 22, 471)
			love.graphics.setColor(255, 255, 255, 255)
		end

		--mission
		love.graphics.draw(interface.mission, (1280-893)/2, 960-77)

		love.graphics.setColor(255, 255, 255, interface.newMissionOpacity)
		love.graphics.draw(interface.newMission, (1280-893)/2+20, ((960-77)-20))
		love.graphics.setColor(255, 255, 255, 255)

		love.graphics.setFont(interface.font)
		love.graphics.printf(interface.currentMission, (1280-893)/2+50, 960-60, 800, "center")

		if build == 1 then
			--build axe
			love.graphics.draw(interface.axe, 0, 0, 0, 5, 5)
		elseif build == 2 then
			--build hammer
			love.graphics.draw(interface.hammer, 0, 0, 0, 5, 5)
		elseif build == 3 then
			--build house
			love.graphics.draw(interface.gem, 0, 0, 0, 5, 5)
		end
	end

	return interface
end

return Interface