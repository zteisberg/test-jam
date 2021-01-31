GameObject = Class{}

function GameObject:init(def)
    self.x = def.x or 0
    self.y = def.y or 0
    self.dx = def.dx or 0
    self.dy = def.dy or 0
    self.sprite = def.sprite
    self.visible = def.visible or false
    self.globalPositioning = def.globalPositioning or false
end

function GameObject:update(dt)

end

function GameObject:draw()
    if self.globalPositioning then
         love.graphics.draw(self.sprite, self.x + globalPosX, self.y + globalPosY)
    else love.graphics.draw(self.sprite, self.x, self.y) end
end