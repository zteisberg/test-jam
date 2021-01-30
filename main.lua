require 'src/Dependencies'

local OS = love.system.getOS()
local PLATFORM = (OS == 'Android' or OS == 'iOS') and 'Mobile' or 'Desktop'
local SCREEN_WIDTH, SCREEN_HEIGHT = love.window.getDesktopDimensions()
local PC_DEFAULT_WIDTH, PC_DEFAULT_HEIGHT = 1280, 720
local MIN_RENDER_WIDTH, MIN_RENDER_HEIGHT  = 512, 288
local MAX_RENDER_WIDTH, MAX_RENDER_HEIGHT = 720, 480

local fullscreen = false
local windowWidth, windowHeight = 1,1
local screenPosX, screenPosY = nil, nil
local aspectRatio = 1.5
local flagScreenResized = false

local background = love.graphics.newImage('assets/background.jpg')

function love.load()
    if (PLATFORM == 'Mobile' or fullscreen) then
         windowWidth, windowHeight = SCREEN_WIDTH, SCREEN_HEIGHT
    else windowWidth, windowHeight = PC_DEFAULT_WIDTH, PC_DEFAULT_HEIGHT
    end
    
    initScreen()
    screenPosX, screenPosY = love.window.getPosition()
    love.window.setTitle('Project Pizza')
end

function love.update(dt)

end

function love.draw()
    push:start()
    love.graphics.draw(background, 0, 0)
    push:finish()
end

function love.resize(w, h)
    push:resize(w, h)
    windowWidth, windowHeight = w, h
    flagScreenResized = true
end

function love.mousefocus()
    if flagScreenResized then
        initScreen()
        love.window.setPosition(screenPosX, screenPosY)
        flagScreenResized = false
    end
end

-- (Re)initializes the screen on function call.
-- Supports aspect ratios from 5:2 to 16:15
function initScreen()
    aspectRatio = windowWidth / windowHeight
    local virtualWidth  = aspectRatio > 1 and MIN_RENDER_WIDTH or MIN_RENDER_HEIGHT
    local virtualHeight = aspectRatio > 1 and MIN_RENDER_HEIGHT or MIN_RENDER_WIDTH

    if aspectRatio > 1.5 then
         virtualWidth  = math.min(MIN_RENDER_HEIGHT * aspectRatio, MAX_RENDER_WIDTH)
    elseif aspectRatio < 0.667 then
         virtualHeight = math.min(MIN_RENDER_HEIGHT / aspectRatio, MAX_RENDER_WIDTH)
    elseif aspectRatio < 1 then
         virtualWidth  = math.min(MIN_RENDER_WIDTH  * aspectRatio, MAX_RENDER_HEIGHT)
    else virtualHeight = math.min(MIN_RENDER_WIDTH  / aspectRatio, MAX_RENDER_HEIGHT)
    end
    
    push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight,{
        vsync = true,
        fullscreen = fullscreen,
        resizable = true,
    })
end