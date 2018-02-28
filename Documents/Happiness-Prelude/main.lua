--Libraries
--HC = require "libs/HC" --hit detection library

--set background to blue for testing
--love.graphics.setBackgroundColor( 66, 197, 244 )

function reloadGlobals()
	--globals
	wWidth = love.graphics.getWidth()
	wHeight = love.graphics.getHeight()
	scrollSpeed = 4
	--starting position
	xOffset = -(35*100)
	yOffset = -(38*80)
	gameState = "splash"
	heroX = 0
	heroY = 0
	mouseX = 0
	mouseY = 0
	mouseMove = false
	xQuad = 0
	yQuad = 0
	gender = "male"
	musicVolume = 0.7

	--scoring
	gems = -1
	wood = -1
	rock = -1
	build = 0

	map1 = map2

	--tools
	currentMission = "Hmmm...?"
	hasHammer = false
	hammerUsable = 100
	hasAxe = false
	axeUsable = 100
	hasHouse = false

	test = 0
end

--map data import
require "data/map_data"

reloadGlobals()

local Controls = require "modules/controls"
controls = Controls:Init()

local Mouse = require "modules/mouse"
mouse = Mouse:Init()

local Music = require "modules/music"
music = Music:Init()

local MainMenu = require "modules/main_menu"
mainMenu = MainMenu:Init()

local Interface = require "modules/interface"
interface = Interface:Init()

local Missions = require "modules/missionHandler"
missions = Missions:Init()

local Hero = require "modules/hero"
hero = Hero:Init()

local Map = require "modules/map"
map = Map:Init()

local MapZ = require "modules/map_z_plus"
mapZ = MapZ:Init()

local MapOverlay = require "modules/map_overlay"
mapOverlay = MapOverlay:Init()

local MapUnderlay = require "modules/map_underlay"
mapUnderlay = MapUnderlay:Init()

local Background = require "modules/background"
background = Background:Init()

-- local Clouds = require "modules/clouds"
-- clouds = Clouds:Init()


function love.load()
	reloadGlobals()

	music:load()
	background:load()

	missions:load()

	mainMenu:load()
	interface:load()

	mapUnderlay:load()
	map:load()
	hero:load()
	mapZ:load()
	mapOverlay:load()
	-- clouds:load()
	slime = love.graphics.newImage('assets/images/characters/slime.png')
end

function love.update(dt)
	if gameState == "splash" 
		or gameState == "mainMenu" 
		or gameState == "chooseSex" 
		or ameState == "ending" then
			mainMenu:update()
	elseif gameState == "inGame" then
		missions:update()

		if build == 0 then
			controls:update()

			mapUnderlay:update()
			map:update()
			hero:update()
			mapZ:update()
			mapOverlay:update()
			--mapZ.update()
			mapZPS:update(dt)
		end

		interface:update()
		-- clouds:update()
	end

	mouse:update()
	love.graphics.print( "DT = " .. dt, 10, 10 )
end

function love.draw()
	if math.floor(heroX/map1tileWidth) < 86 then
		background:draw()
	end

	if gameState == "splash" 
		or gameState == "mainMenu" 
		or gameState == "chooseSex" 
		or gameState == "ending" then
			mainMenu:draw()
	elseif gameState == "inGame" then
		if math.floor(heroX/map1tileWidth) < 86 then
			mapUnderlay:draw()
		end
		map:draw()
		hero:draw()
		mapZ:draw()
		mapOverlay:draw()

		interface:draw()
		-- clouds:draw()
	end

	music:update()

	--missions:draw()
	--love.graphics.print( "Blah = " .. map1[math.floor(heroY/map1tileHeight)][math.floor(heroX/map1tileWidth)], 10, 10 )
	--love.graphics.print("test  = " .. math.floor((heroX/map1tileWidth)),10,60)
end