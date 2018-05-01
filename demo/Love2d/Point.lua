
require "Class"

Point = class()

function Point:init(maxX,maxY)
	self.x = math.random(0,maxX)
	self.y = math.random(0,maxY)
	self.state = self.x > self.y and { 1, 0, 0 } or { 0, 1, 0 }
	self.stateGuessed = { 1,1,1}
end

function Point:guessed(guess)
	self.stateGuessed = guess > 0 and { 1, 0, 0 } or { 0, 1, 0 }
end

function Point:draw()
	love.graphics.setColor(self.state)
    love.graphics.circle("fill", self.x, self.y, 10) 
    love.graphics.setLineWidth(3)
	love.graphics.setColor(self.stateGuessed)
    love.graphics.circle("line", self.x, self.y, 10) 
end