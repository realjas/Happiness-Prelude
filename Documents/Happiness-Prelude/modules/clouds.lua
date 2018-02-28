local Clouds = {}

function Clouds:Init()
	local clouds = {}

	clouds.offset = 0

	function clouds.load()
		clouds.img = love.graphics.newImage('assets/images/fx/clouds.jpg')
	end

	function clouds.update()
		clouds.offset = clouds.offset - (scrollSpeed/2)
	end

	function clouds.draw()
		love.graphics.setBlendMode("screen")
		love.graphics.draw(clouds.img, clouds.offset+xOffset*1.5, yOffset*1.5, 0, 10, 10)
		love.graphics.setBlendMode("alpha")
	end

	return clouds
end

return Clouds