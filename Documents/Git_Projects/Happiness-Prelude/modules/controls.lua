Controls = {}

function Controls:Init()
	local controls = {}

	function controls.update()
		if love.keyboard.isDown( "up" ) then
			yOffset = yOffset+scrollSpeed*delta
		end
		if love.keyboard.isDown( "down" ) then
			yOffset = yOffset-scrollSpeed*delta
		end
		if love.keyboard.isDown( "left" ) then
			xOffset = xOffset+scrollSpeed*delta
		end
		if love.keyboard.isDown( "right" ) then
			xOffset = xOffset-scrollSpeed*delta
		end
	end

	return controls
end

return Controls