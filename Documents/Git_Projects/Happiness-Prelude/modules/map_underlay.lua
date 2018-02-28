local MapUnderlay = {}

function MapUnderlay:Init()
	local mapUnderlay = {}

	--add map attributes here
	mapUnderlay.tileWidth = map1tileWidth
	mapUnderlay.tileHeight = map1tileHeight
	mapUnderlay.rand = 0
	mapUnderlay.data = map1Underlay
	mapUnderlay.tileWidth = map1tileWidth
	mapUnderlay.tileHeight = map1tileHeight
	mapUnderlay.width = math.floor(map1width/2)
	mapUnderlay.height = math.floor(map1height/2)

	function mapUnderlay.load()
		mapUnderlay.star = love.graphics.newImage('assets/images/objects/star.png')
		for x = 1, mapUnderlay.width do
	    	for y = 1, mapUnderlay.height do
	    		mapUnderlay.rand = math.floor(math.random(30)/30)
	    		mapUnderlay.data[y][x] = 0
	    		if mapUnderlay.rand == 1 then
		    		mapUnderlay.data[y][x] = mapUnderlay.rand
		    	end
		    end
	    end
	end
	function mapUnderlay.update()

	end
	function mapUnderlay.draw()
		for x = 1, mapUnderlay.width do
	    	for y = 1, mapUnderlay.height do
	    		if mapUnderlay.data[y][x] == 1 then
	    			mapUnderlay.rand = math.floor(math.random(55))+200
					love.graphics.setColor(math.floor(math.random(155))+100, math.floor(math.random(155))+100, math.floor(math.random(155))+100, 255)
	    			love.graphics.draw(mapUnderlay.star, x*mapUnderlay.tileWidth+(xOffset/1.5), y*mapUnderlay.tileHeight+(yOffset/1.5), 0, math.floor(math.random(0.75))+0.75, 0.5, 1, 1)
	    		end
	    	end
	    end
	    love.graphics.setColor(255, 255, 255, 255)
	end

	return mapUnderlay
end

return MapUnderlay