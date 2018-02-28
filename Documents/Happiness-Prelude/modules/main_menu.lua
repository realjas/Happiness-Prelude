local MainMenu = {}

function MainMenu:Init()
	local menu = {}
	menu.timer = 0

	function menu.load()
		--load splash, title and button here
		menu.splash = love.graphics.newImage('assets/images/menu/sinthesis.png')
		menu.mainWindow = love.graphics.newImage('assets/images/menu/main_window.png')
		menu.window = love.graphics.newImage('assets/images/menu/choose_sex.png')
		menu.startButton = love.graphics.newImage('assets/images/menu/start_button.png')
		menu.boyButton = love.graphics.newImage('assets/images/menu/boy_button.png')
		menu.girlButton = love.graphics.newImage('assets/images/menu/girl_button.png')
		menu.ending = love.graphics.newImage('assets/images/menu/sinthesis.png')
		menu.intro = love.audio.newSource('assets/sounds/intro.wav')
		menu.click = love.audio.newSource('assets/sounds/click.wav')
	end

	function menu.update()
		menu.timer = menu.timer + 1
		--check for button click within area here
		if gameState == "splash" then
			if menu.timer == 1 then
				menu.intro:play()
			end
			if menu.timer > 240 then --love.mouse.isDown(1) or 
				gameState = "mainMenu"
			end
		end

		if gameState == "mainMenu"
			and love.mouse.isDown(1) 
			and mouseX >= (1280-230)/2 and mouseX <= ((1280-230)/2)+230 
			and mouseY >= ((550-78)/2)+300 and mouseY <= (((550-78)/2)+78)+300 then
				gameState = "chooseSex"
				menu.click:play()
		end

		if love.mouse.isDown(1) then
			if gameState == "chooseSex" then
				if mouseX >= (1280-230)/2 and mouseX <= ((1280-230)/2)+230 
					and mouseY >= ((810-78)/2) and mouseY <= (((810-78)/2)+78) then
						gender = "male"
						gameState = "inGame"
						musicVolume = 0.5
						menu.click:play()
				end
				if mouseX >= (1280-230)/2 and mouseX <= ((1280-230)/2)+230 
					and mouseY >= ((810-78)/2)+200 and mouseY <= (((810-78)/2)+78)+200 then
						gender = "female"
						gameState = "inGame"
						musicVolume = 0.5
						menu.click:play()
				end
			end
		end

		if gameState == "ending" then
			if love.mouse.isDown(1) or menu.timer > 240 then
				love.event.quit( "restart" )
				-- love.load()
				-- gameState = "mainMenu"
			end
		end
	end

	function menu.draw()
		if gameState == "splash" then
			love.graphics.draw(menu.splash,0,0)
		elseif gameState == "mainMenu" then
			love.graphics.draw(menu.mainWindow,(1280-1128)/2,(960-626)/2)
			love.graphics.draw(menu.startButton,(1280-230)/2,((550-78)/2)+300)
		elseif gameState == "chooseSex" then
			love.graphics.draw(menu.window,(1280-1128)/2,(960-626)/2)
			love.graphics.draw(menu.boyButton,(1280-230)/2,((810-78)/2))
			love.graphics.draw(menu.girlButton,(1280-230)/2,((810-78)/2)+200)
		elseif gameState == "ending" then
			love.graphics.draw(menu.ending, 0, 0)
		end
	end

	return menu
end

return MainMenu