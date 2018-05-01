package.path = package.path .. ";../../src/?.lua"
require "Point"
require "Perceptron"


function love.load(arg)
	math.randomseed( os.time() )
	p = Perceptron(2)
	points = {}
	for i=1,100 do
		points[i] = Point(love.graphics.getWidth(),love.graphics.getHeight())
	end

end

function love.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end


	if love.keyboard.isDown('return') then
		--train
		for i,point in ipairs(points) do
			point:guessed(p:compute({point.x,point.y}))
		end
	end

end

function love.draw(dt)
	for i,v in ipairs(points) do
		v:draw()
	end
end