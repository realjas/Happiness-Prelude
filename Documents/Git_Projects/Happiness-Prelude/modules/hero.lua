local Hero = {}

function Hero:Init()
	local hero = {}

	--add hero attributes here
	hero.x = wWidth/2
	hero.y = wHeight/2
	hero.baseScale = 1
	hero.xScale = 1
	hero.yScale = 1
	hero.stepScale = 0.013
	--hero.walkSpeed = 2.5
	hero.walkHeight = "stop"
	hero.isWalking = true
	hero.face = {}
	hero.face.x = 0
	hero.face.y = 0

	hero.mapTileWidth = map1tileWidth
	hero.mapTileHeight = map1tileHeight

	hero.initLoad = false

	function hero.load()
		hero.face.img = love.graphics.newImage('assets/images/characters/boy_face.png')

		--load sound effects
		hero.stepGrass = love.audio.newSource('assets/sounds/step_grass.wav')
		hero.stepDirt = love.audio.newSource('assets/sounds/step_dirt.wav')
		hero.gem = love.audio.newSource('assets/sounds/coin.wav')
		hero.smash = love.audio.newSource('assets/sounds/smash_rock.wav')
		hero.tree = love.audio.newSource('assets/sounds/chopping_wood.wav')
		hero.enter = love.audio.newSource('assets/sounds/enter_cave.wav')
	end

	function hero.update()
		if hero.initLoad == false then
			if gender == "female" then
				hero.img = love.graphics.newImage('assets/images/characters/girl.png')
			elseif gender == "male" then
				hero.img = love.graphics.newImage('assets/images/characters/boy.png')
			end
			hero.initLoad = true
		end

		hero.face.x = -12
		hero.face.y = -12
		hero.isWalking = false

		--keyboard control
		if love.keyboard.isDown( "up") and not love.mouse.isDown(1) then
			hero.face.y = -18
			hero.isWalking = true
		elseif love.keyboard.isDown( "down" ) and not love.mouse.isDown(1) then
			hero.face.y = -5
			hero.isWalking = true
		end
		if love.keyboard.isDown( "left" ) and not love.mouse.isDown(1) then
			hero.face.x = -17
			hero.isWalking = true
		elseif love.keyboard.isDown( "right" ) and not love.mouse.isDown(1) then
			hero.face.x = -5
			hero.isWalking = true
		end

		--mouse control
		if hero.face.y == 0 and yQuad == 0 and love.mouse.isDown(1) then
			hero.face.y = -5
			hero.isWalking = true
		elseif hero.face.y == 0 and yQuad == 2 and love.mouse.isDown(1) then
			hero.face.y = 5
			hero.isWalking = true
		end
		if hero.face.x == 0 and xQuad == 0 and love.mouse.isDown(1) then
			hero.face.x = -5
			hero.isWalking = true
		elseif hero.face.x == 0 and xQuad == 2 and love.mouse.isDown(1) then
			hero.face.x = 5
			hero.isWalking = true
		end
		if love.mouse.isDown(1) then
			hero.isWalking = true
		end

		if hero.isWalking == true then
			if hero.yScale > 1.1 then
				hero.walkHeight = "down"
			elseif hero.yScale <= 1 then
				hero.walkHeight = "up"
				if map1[math.floor(((hero.y-yOffset)-hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor((hero.x-xOffset)/hero.mapTileWidth)] == 7 then
					hero.stepGrass:play()
				elseif map1[math.floor(((hero.y-yOffset)-hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor((hero.x-xOffset)/hero.mapTileWidth)] == 6 then
					hero.stepDirt:play()
				end
			end

			if hero.walkHeight == "down" then
				hero.yScale = hero.yScale - hero.stepScale
			elseif hero.walkHeight == "up" then
				hero.yScale = hero.yScale + hero.stepScale
			end
		end

		--feed back pos to global - maybe write a function, so other things can request this data
		heroX = (hero.x-xOffset)
		heroY = (hero.y-yOffset)

		--basic tile collission to counter the offsets
		if map1[math.floor(heroY/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] ~= nil then
			if love.keyboard.isDown( "right" ) or love.mouse.isDown(1) then
				if map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX+hero.mapTileWidth/2)/hero.mapTileWidth)] == 0 
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX+hero.mapTileWidth/2)/hero.mapTileWidth)] == 1
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX+hero.mapTileWidth/2)/hero.mapTileWidth)] == 2
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX+hero.mapTileWidth/2)/hero.mapTileWidth)] == 3
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX+hero.mapTileWidth/2)/hero.mapTileWidth)] == 4 
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX+hero.mapTileWidth/2)/hero.mapTileWidth)] == 5 then
					xOffset = xOffset + (scrollSpeed*delta)
				end
			end
			if love.keyboard.isDown( "left" ) or love.mouse.isDown(1) then
				if map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX-hero.mapTileWidth/2)/hero.mapTileWidth)] == 0 
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX-hero.mapTileWidth/2)/hero.mapTileWidth)] == 1 
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX-hero.mapTileWidth/2)/hero.mapTileWidth)] == 2 
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX-hero.mapTileWidth/2)/hero.mapTileWidth)] == 3 
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX-hero.mapTileWidth/2)/hero.mapTileWidth)] == 4 
					or map1[math.floor(heroY/hero.mapTileHeight)][math.floor((heroX-hero.mapTileWidth/2)/hero.mapTileWidth)] == 5 then
					xOffset = xOffset - (scrollSpeed*delta)
				end
			end
			if love.keyboard.isDown( "up" ) or love.mouse.isDown(1) then
				if map1[math.floor((heroY-hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 0 
					or map1[math.floor((heroY-hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 1 
					or map1[math.floor((heroY-hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 2 
					or map1[math.floor((heroY-hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 3 
					or map1[math.floor((heroY-hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 4 
					or map1[math.floor((heroY-hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 5 then
					yOffset = yOffset - (scrollSpeed*delta)
				end
			end
			if love.keyboard.isDown( "down" ) or love.mouse.isDown(1) then
				if map1[math.floor((heroY+hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 0 
					or map1[math.floor((heroY+hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 1
					or map1[math.floor((heroY+hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 2 
					or map1[math.floor((heroY+hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 3 
					or map1[math.floor((heroY+hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 4 
					or map1[math.floor((heroY+hero.mapTileHeight/2)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 5 then
					yOffset = yOffset + (scrollSpeed*delta)
				end
			end
		end

		-- if map1[math.floor((heroY-hero.mapTileHeight)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)] == 8 then
		-- 	gems = gems + 1
		-- 	map1[math.floor(heroY/hero.mapTileHeight)][math.floor(heroX+hero.mapTileWidth)] = 7
		-- 	hero.gem:play()
		-- end
		-- test = map1[math.floor((heroY-hero.mapTileHeight)/hero.mapTileHeight)][math.floor(heroX/hero.mapTileWidth)]
	end

	function hero.smashRock()
		hammerUsable = 100
		hero.smash:play()
	end
	function hero.cutTree()
		axeUsable = 100
		hero.tree:play()
	end

	function hero.gatherGem()
		if gems == -1 then
			gems = 0
		end
		gems = gems + 1
		hero.gem:play()
	end
	function hero.gatherRock()
		if rock == -1 then
			rock = 0
		end
		rock = rock + 1
		hammerUsable = 100
		hero.gem:play()
	end
	function hero.gatherWood()
		if wood == -1 then
			wood = 0
		end
		wood = wood + 1
		axeUsable = 100
		hero.gem:play()
	end

	function hero.enterCave()
		hero.enter:play()
	end

	function hero.draw()
		if hero.initLoad == true then
			--love.graphics.setBlendMode("alpha")
			--love.graphics.setColor(255, 255, 255, 50)
			love.graphics.draw(hero.img, hero.x, hero.y, 0, hero.xScale, hero.yScale, 45, 100)
			love.graphics.draw(hero.face.img, hero.x+hero.face.x, hero.y+hero.face.y, 0, hero.baseScale, hero.yScale, 33, 90)
		end
	end

	return hero
end

return Hero