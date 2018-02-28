local Map = {}

function Map:Init()
	local map = {}

	--add map attributes here
	map.tileWidth = map1tileWidth
	map.tileHeight = map1tileHeight
	map.width = map1width
	map.height = map1height

	map.fade = 0
	map.fadePhase = "up"
	map.fadeOffset = 0

	map.renderDistance = 8

	tileValue = 0
	testY = 0
	testX = 0

	function map.load()
		--13 cave shadow
		map.caveShadow = love.graphics.newImage('assets/images/tiles/mountain_tile_center_shadow.png')
		--12 cave
		map.cave = love.graphics.newImage('assets/images/tiles/mountain_tile_center.png')
		--11 sign
		map.sign = love.graphics.newImage('assets/images/tiles/sign.png')
		--10 wood
		map.wood = love.graphics.newImage('assets/images/tiles/wood.png')
		--9 rock
		map.sharpRock = love.graphics.newImage('assets/images/tiles/sharp_rock.png')
		--8 gem
		map.gem = love.graphics.newImage('assets/images/tiles/gem.png')
		--7 grass
		map.grass = love.graphics.newImage('assets/images/tiles/grass.png')
		--6 dirt
		map.dirt = love.graphics.newImage('assets/images/tiles/dirt.png')
		--5 water
		map.water = love.graphics.newImage('assets/images/tiles/water.png')
		--4 trees
		map.treeStump = love.graphics.newImage('assets/images/tiles/trees.png')
		--3 rocks
		map.rock = love.graphics.newImage('assets/images/tiles/rocks.png')
		--2 mountains
		map.blocked = love.graphics.newImage('assets/images/tiles/blocked.png')
		--1 
		map.waterfall = love.graphics.newImage('assets/images/tiles/waterfall.png')

		map.tree = love.graphics.newImage('assets/images/objects/tree.png')

		map.marker = love.graphics.newImage('assets/images/tiles/marker.png')
	end

	function map.update()
	end

	function map.draw()
		if map.fadePhase == "up" then
			map.fade = map.fade + math.floor(255/60)
		elseif map.fadePhase == "down" then
			map.fade = map.fade - math.floor(255/60)
		end

		if map.fade <= 0 then
			map.fadePhase = "up"
		elseif map.fade >= 255 then
			map.fadePhase = "down"
		end

		map.fadeOffset = map.fadeOffset + (30/120)
		if map.fadeOffset > 30 then
			map.fadeOffset = 0
			map.fade = 0
		end

		for x = 1, map.width do
	    	for y = 1, map.height do
	    		if x > math.floor(heroX/map.tileWidth)-map.renderDistance and x < math.floor(heroX/map.tileWidth)+map.renderDistance
	    			and y > math.floor(heroY/map.tileHeight)-map.renderDistance and y < math.floor(heroY/map.tileHeight)+map.renderDistance then
		    		if map1[y][x] ~= 0 then
		    			if map1[y][x] == 11 then
				    		love.graphics.draw(map.sign, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 10 then
				    		love.graphics.draw(map.wood, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 9 then
				    		love.graphics.draw(map.sharpRock, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 8 then
				    		love.graphics.draw(map.gem, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 7 then
				    		love.graphics.draw(map.grass, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 6 then
				    		love.graphics.draw(map.dirt, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 5 then
				    		love.graphics.draw(map.water, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 4 then
				    		love.graphics.draw(map.treeStump, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    		love.graphics.draw(map.tree, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset-120, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 3 then
				    		love.graphics.draw(map.rock, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 2 then
				    		love.graphics.draw(map.blocked, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif map1[y][x] == 1 then
				    		love.graphics.setColor(255, 255, 255, map.fade)
				    		love.graphics.draw(map.waterfall, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset+map.fadeOffset-10, 0, 1, 1, 1, 1)
		    				love.graphics.setColor(255, 255, 255, 255)
		    			elseif map1[y][x] == 99 then
				    		love.graphics.draw(map.cave, x*map.tileWidth+xOffset, (y-1)*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    		--love.graphics.draw(map.caveShadow, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	end

				    	--verification of tracking mouse and player position
				    	if x == math.floor(heroX/map.tileWidth) and y == math.floor(heroY/map.tileHeight) then
				    		testY = y
				    		testX = x

				    		--cave entrances/exit
				    		if x == entrance1x and y == entrance1y then
				    			yOffset = -((cave1y+2)*map1tileHeight)+(6*map1tileHeight)
								xOffset = -(cave1x*map1tileWidth)+(6*map1tileWidth)
								hero.enterCave()
				    		end
				    		if x == cave1x and y == cave1y then
				    			yOffset = -((entrance1y+2)*map1tileHeight)+(6*map1tileHeight)
								xOffset = -(entrance1x*map1tileWidth)+(6*map1tileWidth)
								hero.enterCave()
				    		end
				    		if x == entrance2x and y == entrance2y then
				    			yOffset = -((cave2y+2)*map1tileHeight)+(6*map1tileHeight)
								xOffset = -(cave2x*map1tileWidth)+(6*map1tileWidth)
								hero.enterCave()
				    		end
				    		if x == cave2x and y == cave2y then
				    			yOffset = -((entrance2y+2)*map1tileHeight)+(6*map1tileHeight)
								xOffset = -(entrance2x*map1tileWidth)+(6*map1tileWidth)
								hero.enterCave()
				    		end

				    		if map1[y][x] == 8 then
								map1[y][x] = 7
				    			hero:gatherGem()
				    		end
				    		if map1[y][x] == 10 then
				    			map1[y][x] = 7
				    			hero:gatherWood()
				    		end
				    		if map1[y][x] == 9 then
				    			map1[y][x] = 7
				    			hero:gatherRock()
				    		end

				    		if hasAxe == true then
			    				axeUsable = 100
			    				if map1[y][x-1] == 4 then
			    					if love.keyboard.isDown( "space" ) or love.mouse.isDown(1) then
			    						map1[y][x-1] = 10
			    						hero:cutTree()
			    					end

					    			love.graphics.setColor(255, 10, 10, 255)
					    			--love.graphics.draw(map.marker, (x-1)*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
					    			love.graphics.setColor(255, 255, 255, 255)
					    			axeUsable = 255
			    				elseif map1[y][x+1] == 4 then
			    					if love.keyboard.isDown( "space" ) or love.mouse.isDown(1) then
			    						map1[y][x+1] = 10
			    						hero:cutTree()
			    					end

					    			love.graphics.setColor(255, 10, 10, 255)
					    			--love.graphics.draw(map.marker, (x+1)*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
					    			love.graphics.setColor(255, 255, 255, 255)
					    			axeUsable = 255
			    				elseif map1[y-1][x] == 4 then
			    					if love.keyboard.isDown( "space" ) or love.mouse.isDown(1) then
			    						map1[y-1][x] = 10
			    						hero:cutTree()
			    					end

					    			love.graphics.setColor(255, 10, 10, 255)
					    			--love.graphics.draw(map.marker, x*map.tileWidth+xOffset, (y-1)*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
					    			love.graphics.setColor(255, 255, 255, 255)
					    			axeUsable = 255
			    				elseif map1[y+1][x] == 4 then
			    					if love.keyboard.isDown( "space" ) or love.mouse.isDown(1) then
			    						map1[y+1][x] = 10
			    						hero:cutTree()
			    					end

					    			love.graphics.setColor(255, 10, 10, 255)
					    			--love.graphics.draw(map.marker, x*map.tileWidth+xOffset, (y+1)*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
					    			love.graphics.setColor(255, 255, 255, 255)
					    			axeUsable = 255
			    				end
				    		end
				    		if hasHammer == true then
				    			hammerUsable = 100
			    				if map1[y][x-1] == 3 then
			    					if love.keyboard.isDown( "space" ) or love.mouse.isDown(1) then
			    						map1[y][x-1] = 8
			    						hero:smashRock()
			    					end

					    			love.graphics.setColor(255, 10, 10, 255)
					    			--love.graphics.draw(map.marker, (x-1)*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
					    			love.graphics.setColor(255, 255, 255, 255)
					    			hammerUsable = 255
			    				elseif map1[y][x+1] == 3 then
			    					if love.keyboard.isDown( "space" ) or love.mouse.isDown(1) then
			    						map1[y][x+1] = 8
			    						hero:smashRock()
			    					end

					    			love.graphics.setColor(255, 10, 10, 255)
					    			--love.graphics.draw(map.marker, (x+1)*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
					    			love.graphics.setColor(255, 255, 255, 255)
					    			hammerUsable = 255
			    				elseif map1[y-1][x] == 3 then
			    					if love.keyboard.isDown( "space" ) or love.mouse.isDown(1) then
			    						map1[y-1][x] = 8
			    						hero:smashRock()
			    					end

					    			love.graphics.setColor(255, 10, 10, 255)
					    			--love.graphics.draw(map.marker, x*map.tileWidth+xOffset, (y-1)*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
					    			love.graphics.setColor(255, 255, 255, 255)
					    			hammerUsable = 255
			    				elseif map1[y+1][x] == 3 then
			    					if love.keyboard.isDown( "space" ) or love.mouse.isDown(1) then
			    						map1[y+1][x] = 8
			    						hero:smashRock()
			    					end

					    			love.graphics.setColor(255, 10, 10, 255)
					    			--love.graphics.draw(map.marker, x*map.tileWidth+xOffset, (y+1)*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
					    			love.graphics.setColor(255, 255, 255, 255)
					    			hammerUsable = 255
			    				end
				    		end
							--love.graphics.draw(map.marker, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
				    	elseif x == math.floor((mouseX-xOffset)/map.tileWidth) and y == math.floor((mouseY-yOffset)/map.tileHeight) then
				    		--if love.mouse.isDown(1) then
								--love.graphics.draw(map.marker, x*map.tileWidth+xOffset, y*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
								tileValue = map1[y][x]
							--end
						end
					end
				end
	    	end
	    end
	 --love.graphics.print( "tileValue = " .. -((cave1y+1)*map1tileHeight)+6 .. "_" .. -((cave1y+1)*map1tileHeight) .. ", x,y = " .. testY .. "," .. testX, 10, 30 )
	end

	return map
end

return Map
