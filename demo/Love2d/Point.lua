
require "Class"
require "Perceptron"

Point = class()

function Point:init(maxX,maxY)
	if ( type(maxX) == 'table') then 
		self.x = maxX[1]
		self.y = maxX[2]
	else
		self.x = math.random(0,maxX or 100)
		self.y = math.random(0,maxY or 100)
	end
	self.state = self:test() > 0 and { 1, 0, 0 } or { 0, 1, 0 }
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

function Point:test()
	-- return self.x > self.y   -- y=x
	local a = -1
	local b = 600
	return  PerceptronDefault.activation(a*self.x +b- self.y )-- y = a*x+b
end