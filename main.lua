require 'src/Dependencies'

local screenSize = {love.window.getDesktopDimensions()}
local virtualSize = {512, 288}

function love.load()
    love.window.setTitle('Project Pizza')
    print(screenSize.width)
end

function love.resize(w, h)
    push:resize(w, h)
end