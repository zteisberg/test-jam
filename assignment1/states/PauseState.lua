--[[
	PauseState Class
	Author: Jacqueline Vo
	jacquelinevo@rocketmail.com
	
	This is a PauseState class that pauses the game when the player presses 'P'.
]]


PauseState = Class {__includes = BaseState}

function PauseState:init()

end

function PauseState:update(dt)
	if love.keyboard.wasPressed('p') then
		gStateMachine:change('play', self.saved)
		
	end
end

function PauseState:render()
	love.graphics.setFont(hugeFont)
	love.graphics.printf('Pause', 0, 100, VIRTUAL_WIDTH, 'center')

end

function PauseState:enter(params)
	self.saved = params
end

function PauseState:exit()
end