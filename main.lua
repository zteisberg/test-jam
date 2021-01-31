require 'src/Dependencies'

local OS = love.system.getOS()
local MOBILE = (OS == 'Android' or OS == 'iOS') and true or false
local SCREEN_WIDTH, SCREEN_HEIGHT = love.window.getDesktopDimensions()
local PC_DEFAULT_WIDTH, PC_DEFAULT_HEIGHT = 1280, 720
local MIN_RENDER_WIDTH, MIN_RENDER_HEIGHT  = 512, 288
local MAX_RENDER_WIDTH, MAX_RENDER_HEIGHT = 720, 480

local fullscreen = false
local landscape = true
local windowWidth, windowHeight = 1,1
local virtualWidth, virtualHeight = 1,1
local screenPosX, screenPosY = nil, nil
local aspectRatio = 1.5
local flagScreenResized = false

function love.load()
    if (MOBILE or fullscreen) then
         windowWidth, windowHeight = SCREEN_WIDTH, SCREEN_HEIGHT
    else windowWidth, windowHeight = PC_DEFAULT_WIDTH, PC_DEFAULT_HEIGHT
    end
    
    initScreen()
    screenPosX, screenPosY = love.window.getPosition()
    love.window.setTitle('Project Pizza')
end

function love.update(dt)
    print(love.window.hasMouseFocus())
end

function love.draw()
    push:start()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('fill',0,0,virtualWidth,virtualHeight)
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

function love.mousepressed()
    print(love.mouse.getPosition())
end

function love.keypressed()
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
    landscape = aspectRatio > 1 and true or false
    
    local longSide  = MIN_RENDER_WIDTH
    local shortSide = MIN_RENDER_HEIGHT
    local inverseRatio = 1 / aspectRatio
    if aspectRatio > 1.5 or aspectRatio < 0.667 then
         longSide  = math.min(MIN_RENDER_HEIGHT * (landscape and aspectRatio or inverseRatio), MAX_RENDER_WIDTH)
    else shortSide = math.min(MIN_RENDER_WIDTH  * (landscape and inverseRatio or aspectRatio), MAX_RENDER_HEIGHT) end

    if landscape then
         virtualWidth,virtualHeight = longSide, shortSide
    else virtualWidth,virtualHeight = shortSide, longSide end

    push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight,{
        vsync = true,
        fullscreen = fullscreen,
        resizable = true,
    })
end