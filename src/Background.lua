Background = Class{}

function Background:init()
    tileWidth, tileHeight = 64,64
end

function Background:update(dt)
end

function Background:testRender()
    local x, y = 0,0
    local w, h = 1,1
    for i = 1, #tiles['grass'] do
        love.graphics.draw(textures['grass'], tiles['grass'][i], x+w, y+h)
        x = x + tileWidth
        w = w + 1
        if x + tileWidth > virtualWidth then
            x = 0
            y = y + tileHeight
            w = 1
            h = h + 1

        end
    end
end

function Background:render()
    for y = -(globalPosY % tileHeight), virtualHeight+tileHeight, tileHeight do
        for x = -(globalPosX % tileWidth), virtualWidth +tileWidth, tileWidth do
            local hashval = (globalPosX+x+(globalPosY+y)*8)/tileWidth
            local flipx = crc32:hash(hashval)%2 == 0 and 1 or -1
            local index = crc32:hash(hashval+1)%#tiles['grass']+1
            love.graphics.draw(textures['grass'],tiles['grass'][index],x,y,0,flip,1,tileWidth/2,tileHeight/2)
        end
    end
end