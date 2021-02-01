function ExtractSprites(sheet, width, height)
    local rows = sheet:getWidth()  / width
    local cols = sheet:getHeight() / height
    local sprites = {}
    
    for row=0, rows-1 do
        for col=0, cols-1 do
            sprites[#sprites+1] =
                love.graphics.newQuad(row * width, col*height,
                width, height, sheet:getDimensions())
        end
    end
    return sprites
end
