require 'src/Dependencies'

local OS = love.system.getOS()
local MOBILE = (OS == 'Android' or OS == 'iOS') and true or false
local SCREEN_WIDTH, SCREEN_HEIGHT = love.window.getDesktopDimensions()
local PC_DEFAULT_WIDTH, PC_DEFAULT_HEIGHT = 540,900
local MIN_RENDER_WIDTH, MIN_RENDER_HEIGHT = 512, 288
local MAX_RENDER_WIDTH, MAX_RENDER_HEIGHT = 720, 480
local SIN90 = {0,1,0,-1}
local COS90 = {1,0,-1,0}

local fullscreen = false
local landscape  = true
local windowPosX, windowPosY = nil, nil
local windowWidth,  windowHeight  = 1,1
local aspectRatio = 1.5
local flagScreenResized = false

local turning = true
local turnCounter = 0
local turnDuration = 50
local turnDir = 180

virtualWidth, virtualHeight = 1,1
globalPosX, globalPosY = 0, 0
globalScrollX, globalScrollY = 0, 0
globalScrollSpeed = 450


function love.load()
    if (MOBILE or fullscreen) then
         windowWidth, windowHeight = SCREEN_WIDTH, SCREEN_HEIGHT
    else windowWidth, windowHeight = PC_DEFAULT_WIDTH, PC_DEFAULT_HEIGHT
    end
    
    initScreen()
    windowPosX, windowPosY = love.window.getPosition()
    love.window.setTitle('Project Pizza')
    love.graphics.setDefaultFilter('nearest','nearest')

    LoadSprites()

    bg = Background()
end

function love.update(dt)
    globalPosX = globalPosX + globalScrollX * dt
    globalPosY = globalPosY + globalScrollY * dt

    if turning then
        local dx = 2*globalScrollSpeed/turnDuration
        turnCounter = turnCounter + 1
        if turnCounter <= turnDuration/2 then
            globalScrollX = globalScrollX - sign(globalScrollX)*dx
            globalScrollY = globalScrollY - sign(globalScrollY)*dx
        elseif turnCounter <= turnDuration then
            local index = math.floor(turnDir/90)
            globalScrollX = globalScrollX - SIN90[index+1]*dx
            globalScrollY = globalScrollY + COS90[index+1]*dx
        else
            globalScrollX = math.floor(globalScrollX+0.5)
            globalScrollY = math.floor(globalScrollY+0.5)
            turning = false
            turnCounter = 0
        end
    end

end

function love.draw()
    push:start()
    bg.testRender()
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
        love.window.setPosition(windowPosX, windowPosY)
        flagScreenResized = false
    end
end

function love.keypressed(key)
    if flagScreenResized then
        initScreen()
        love.window.setPosition(windowPosX, windowPosY)
        flagScreenResized = false
    end

    if not turning then
        if key == 'e' then
            turnDir = (turnDir + 90) % 360
            turning = true
        elseif key == 'q' then
            turnDir = (turnDir - 90) % 360
            turning = true
        end
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