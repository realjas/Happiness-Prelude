local MapOverlay = {}

function MapOverlay:Init()
	local mapOverlay = {}

	--add map attributes here
	mapOverlay.tileWidth = map1tileWidth
	mapOverlay.tileHeight = map1tileHeight
	mapOverlay.rand = 0
	mapOverlay.data = map1Overlay
	mapOverlay.tileWidth = map1tileWidth
	mapOverlay.tileHeight = map1tileHeight
	mapOverlay.width = math.floor(map1width*2)
	mapOverlay.height = math.floor(map1height*2)
	mapOverlay.caveXOffset = 1000
	mapOverlay.caveYOffset = 1000
	mapOverlay.renderDistance = 3

	function mapOverlay.load()
		mapOverlay.star = love.graphics.newImage('assets/images/objects/star.png')
		mapOverlay.peak = love.graphics.newImage('assets/images/objects/peak.png')
		mapOverlay.caveShadow = love.graphics.newImage('assets/images/fx/cave_shadow.png')

		for x = 1, mapOverlay.width do
	    	for y = 1, mapOverlay.height do
	    		mapOverlay.rand = math.floor(math.random(30)/30)
	    		mapOverlay.data[y][x] = 0
	    		if mapOverlay.rand == 1 then
		    		mapOverlay.data[y][x] = mapOverlay.rand
		    	end
		    end
	    end
	end
	function mapOverlay.update()

	end
	function mapOverlay.draw()
		for x = 1, mapOverlay.width do
	    	for y = 1, mapOverlay.height do
	    		if mapOverlay.data[y][x] == 1 and math.floor(heroX/map1tileWidth) < 86 then
	    			mapOverlay.rand = math.floor(math.random(100))+155
	    			love.graphics.setColor(255, 255, 255, mapOverlay.rand)
	    			love.graphics.draw(mapOverlay.star, x*mapOverlay.tileWidth+(xOffset*1.5), y*mapOverlay.tileHeight+(yOffset*1.5), 0, 1, 1, 1, 1)
	    		elseif mapOverlay.data[y][x] == 1 and math.floor(heroX/map1tileWidth) > 86 then
	    			love.graphics.draw(mapOverlay.peak, x*mapOverlay.tileWidth+((xOffset+mapOverlay.caveXOffset)*1.25), y*mapOverlay.tileHeight+((yOffset+mapOverlay.caveYOffset)*1.25), 0, 1, 1, 1, 1)
	    		end
	    	end
	    end
	    love.graphics.setColor(255, 255, 255, 255)
	    if math.floor(heroX/map1tileWidth) > 86 then
		    love.graphics.draw(mapOverlay.caveShadow,0,0)
		end
	end

	return mapOverlay
end

return MapOverlay