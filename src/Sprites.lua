Sprites = {}

function LoadSprites()
    textures = {
        ['grass'] = love.graphics.newImage('assets/grass.png'),
        ['sidewalk'] = love.graphics.newImage('assets/roads.png'),
    }

    tiles = {
        ['grass'] = ExtractSprites(textures['grass'],64,64),
        ['swCorners'] = ExtractSidewalkCorners(textures['sidewalk'],19,16,5,6),
        ['swHorizontal'] = ExtractSidewalkHorizontal(textures['sidewalk'],19,16,6,5,6),
        ['swVertical'] = ExtractSidewalkVertical(textures['sidewalk'],19,16,3,5,6),
    }
end

function ExtractSprites(sheet, width, height)
    local rows = sheet:getWidth()  / width
    local cols = sheet:getHeight() / height
    local sprites = {}
    
    for row=0, rows-1 do
        for col=0, cols-1 do
            sprites[#sprites+1] =
                love.graphics.newQuad(row * width, col*height,
                width, height, sheet:getDimensions()
            )
        end
    end
    return sprites
end

function ExtractSidewalkCorners(sheet, width, height, xGap, yGap)
    local sprites = {}
    local x = {0, sheet:getWidth() - width*(xGap+2), width*(xGap+1), sheet:getWidth() - width}
    local y = {0, height*(yGap+1)}
    for yIndex = 1, #y do
        for xIndex = 1, #x do
            sprites[#sprites+1] =
                love.graphics.newQuad(x[xIndex],y[yIndex],
                width, height, sheet:getDimensions()
            )
        end
    end
    return sprites
end

function ExtractSidewalkHorizontal(sheet, width, height, xCount, xGap, yGap)
    local sprites = {}
    for y = 0, height*(yGap+1)+1, height*(yGap+1) do
        for x = width*(xGap+2), width*(xGap+xCount), width do
            sprites[#sprites+1] =
                love.graphics.newQuad(x,y,width,height,sheet:getDimensions()
            )
        end
    end
    return sprites
end

function ExtractSidewalkVertical(sheet, width, height, yCount, xGap, yGap)
    local sprites = {}
    local x = {0, sheet:getWidth() - width*(xGap+2), width*(xGap+1), sheet:getWidth() - width}
    for xIndex = 1, #x do
        for y = height*(yGap+2), height*(yGap+yCount+1), height do
            sprites[#sprites+1] =
                love.graphics.newQuad(x[xIndex],y,
                width, height, sheet:getDimensions()
            )
        end
    end
    return sprites
end
