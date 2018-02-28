local Music = {}

function Music:Init()
	local music = {}
	music.state = gameState
	music.place = math.floor((heroX/map1tileWidth)/100)
	music.trigger = false

	function music.load()

	end

	function music.update()
		if (music.state ~= gameState) or (music.place < math.floor((heroX/map1tileWidth)/86)) or (music.place > math.floor((heroX/map1tileWidth)/86)) then
			music.state = gameState
			music.place = math.floor((heroX/map1tileWidth)/86)
			music.trigger = false
		end
		if music.state == "mainMenu" and music.trigger == false then
			music.track = love.audio.newSource('assets/music/main_menu.mp3')
			music.track:setVolume(musicVolume)
			music.track:play()
			music.trigger = true
		elseif music.state == "inGame" and music.trigger == false then
			music.track:stop()
			if math.floor(heroX/map1tileWidth) >= 86 then
				music.track = love.audio.newSource('assets/music/cave.mp3')
			else
				music.track = love.audio.newSource('assets/music/island.mp3')
			end
			music.track:setVolume(musicVolume)
			music.track:setLooping(true)
			music.track:play()
			music.trigger = true
		elseif music.state == "ending" and music.trigger == false then
			--music.track:stop()
			music.track = love.audio.newSource('assets/music/ending.mp3')
			music.track:setVolume(musicVolume)
			music.track:setLooping(true)
			music.track:play()
			music.trigger = true
		end
	end

	function music.draw()
	end

	return music
end

return Music