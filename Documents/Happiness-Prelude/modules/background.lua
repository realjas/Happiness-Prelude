local Background = {}

function Background:Init()
	local background = {}

	function background.load()
		background.img = love.graphics.newImage('assets/images/background/space.jpg')
	end

	function background.draw()
		love.graphics.draw(background.img, 0, 0)
	end

	return background
end

return Background