--[[
	Achievement Class
	Author: Jacqueline Vo
	jacquelinevo@rocketmail.com	
	
	The achievements you get for each score you reach
]]

Achievements = Class {}

function Achievements:init()
	self.third = love.graphics.newImage('medal5.png')
	self.x = VIRTUAL_WIDTH / 2 - self.third:getWidth () / 2
	self.y = -40
	self.dy = 1
	self.timer = 0
	self.visible = false
	self.text = ''
	self.second = love.graphics.newImage('medal9.png')
	
	self.first = love.graphics.newImage('medal7.png')
	
	self.reward = false
end

function Achievements:update(dt)
	if self.visible then
		if self.y < 3 then

			self.y = self.y + self.dy 
		end
		self.timer = self.timer + dt
		
		if self.timer > 5 then
			self.visible = false
	
		end
			
	end
end

function Achievements:getAchievement(award)
	self.visible = true
	self.timer = 0 
	self.y = -40
	if award == 'first' then
		self.reward = self.first
		self.text = 'First!'
	
	elseif award == 'second' then	
		self.reward = self.second
		self.text = 'Second!'
	
	elseif award == 'third' then
		self.reward = self.third
		self.text = 'Third!'
	end
end

function Achievements:render()

	if self.visible then
		love.graphics.draw(self.reward, self.x, self.y, 0, 2, 2)
		love.graphics.setFont(mediumFont)
		love.graphics.print (self.text, 80, 40)
	end
end