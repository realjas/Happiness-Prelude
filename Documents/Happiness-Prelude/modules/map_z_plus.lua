local MapZ = {}

function MapZ:Init()
	local mapZ = {}

	--add mapZ attributes here
	mapZ.tileWidth = map1tileWidth
	mapZ.tileHeight = map1tileHeight
	mapZ.width = map1width
	mapZ.height = map1height
	mapZ.data = map1

	function mapZ.load()
		mapZ.tree = love.graphics.newImage('assets/images/objects/tree.png')
		mapZ.house = love.graphics.newImage('assets/images/objects/house.png')
		mapZ.caveLeft = love.graphics.newImage('assets/images/tiles/mountain_tile_left.png')
		mapZ.caveRight = love.graphics.newImage('assets/images/tiles/mountain_tile_right.png')

		--particle system
		mapZPSimg = love.graphics.newImage('assets/images/objects/star.png')
 
		mapZPS = love.graphics.newParticleSystem(mapZPSimg, 32)
		mapZPS:setParticleLifetime(2, 10) -- Particles live at least 2s and at most 5s.
		mapZPS:setEmissionRate(5)
		mapZPS:setSizeVariation(0)
		mapZPS:setLinearAcceleration(-20, -40, 20, 0) -- Random movement in all directions.
		mapZPS:setColors(255, 255, 255, 150, 10, 169, 255, 0) -- Fade to transparency.
		mapZPS:setRotation( 1, 5 ) -- full rotation in rads is 6.28
	end

	function mapZ.update(dt)
	end

	function mapZ.draw()
		for x = 1, mapZ.width do
	    	for y = 1, mapZ.height do
	    		if mapZ.data[y][x] ~= 0 then
	    			if mapZ.data[y][x] == 4 then
			    		love.graphics.draw(mapZ.tree, x*mapZ.tileWidth+xOffset, y*mapZ.tileHeight+yOffset-120, 0, 1, 1, 1, 1)
			    	elseif hasHouse == true and x == 46 and y == 33 then
			    		love.graphics.draw(mapZ.house, (44*mapZ.tileWidth+xOffset)+16, (28*mapZ.tileHeight+yOffset)-18, 0, 1, 1, 1, 1)
					elseif map1[y][x] == 99 then
			    		love.graphics.draw(mapZ.caveRight, (x+1)*map.tileWidth+xOffset, (y-2)*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
			    		love.graphics.draw(mapZ.caveLeft, (x-1)*map.tileWidth+xOffset, (y-2)*map.tileHeight+yOffset, 0, 1, 1, 1, 1)
		    		elseif map1[y][x] == 8 then
		    			love.graphics.draw(mapZPS, x*map.tileWidth+xOffset+(map.tileWidth/2), y*map.tileHeight+yOffset+(map.tileHeight/2), 0, 0.7)
		    		--elseif map1[y][x] == 5 then --water particle experiment
		    			--love.graphics.draw(mapZPS, x*map.tileWidth+xOffset+(map.tileWidth/2), y*map.tileHeight+yOffset+(map.tileHeight/2), 0, 0.5)
			    	end
				end
	    	end
	    end
	end

	return mapZ
end

return MapZ
