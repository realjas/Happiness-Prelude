Mouse = {}

function Mouse:Init()
	local mouse = {}

	function mouse.update()
		mouseX, mouseY = love.mouse.getPosition()

		xQuad = math.floor(mouseX/(wWidth/3))
		yQuad = math.floor(mouseY/(wHeight/3))

		mouseMove = false

		if xQuad == 0 and love.mouse.isDown(1) then
			xOffset = xOffset+scrollSpeed
			mouseMove = true
		end
		if xQuad == 2 and love.mouse.isDown(1) then
			xOffset = xOffset-scrollSpeed
			mouseMove = true
		end

		if yQuad == 0 and love.mouse.isDown(1) then
			yOffset = yOffset+scrollSpeed
			mouseMove = true
		end
		if yQuad == 2 and love.mouse.isDown(1) then
			yOffset = yOffset-scrollSpeed
			mouseMove = true
		end
	end

	return mouse
end

return Mouse