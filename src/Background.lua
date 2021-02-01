Background = Class{}

function Background:init()
    grassWidth, grassHeight = 64,64
    swWidth, swHeight = 19,16
end

function Background:update(dt)
end

function Background:testRender()
    local x, y = 0,0
    local w, h = 1,1
    function newline(spriteHeight)
        x = 0
        y = y + spriteHeight
        w = 1
        h = h + 1
    end

    for i = 1, #tiles['grass'] do
        love.graphics.draw(textures['grass'], tiles['grass'][i], x+w, y+h)
        x = x + grassWidth
        w = w + 1
        if x + grassWidth > virtualWidth then
            newline(grassHeight)
        end
    end
    
    if x > 0 then
        newline(grassHeight)
    end

    for i = 1, #tiles['swCorners'] do
        love.graphics.draw(textures['sidewalk'],tiles['swCorners'][i], x+w, y+h)
        x = x + swWidth
        w = w + 1
        if x + swWidth > virtualWidth then
            newline(swHeight)
        end 
    end
    
    if x > 0 then
        newline(swHeight)
    end
    
    for i = 1, #tiles['swHorizontal'] do
        love.graphics.draw(textures['sidewalk'],tiles['swHorizontal'][i], x+w, y+h)
        x = x + swWidth
        w = w + 1
        if x + swWidth > virtualWidth then
            newline(swHeight)
        end 
    end
    
    if x > 0 then
        newline(swHeight)
    end
    
    for i = 1, #tiles['swVertical'] do
        love.graphics.draw(textures['sidewalk'],tiles['swVertical'][i], x+w, y+h)
        x = x + swWidth
        w = w + 1
        if x + swWidth > virtualWidth then
            newline(swHeight)
        end 
    end
end

function Background:render()
    for y = -(globalPosY % grassHeight), virtualHeight+grassHeight, grassHeight do
        for x = -(globalPosX % grassWidth), virtualWidth +grassWidth, grassWidth do
            local hashval = (globalPosX+x+(globalPosY+y)*8)/grassWidth
            local flipx = crc32:hash(hashval)%2 == 0 and 1 or -1
            local index = crc32:hash(hashval+1)%#tiles['grass']+1
            love.graphics.draw(textures['grass'],tiles['grass'][index],x,y,0,flip,1,grassWidth/2,grassHeight/2)
        end
    end
end