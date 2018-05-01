package.path = package.path .. ";../../src/?.lua"
require "Point"
require "Perceptron"


function love.load(arg)
	math.randomseed( os.time() )
	p = Perceptron(3)
	points = {}
	for i=1,100 do
		points[i] = Point(love.graphics.getWidth(),love.graphics.getHeight())
	end

	for i,point in ipairs(points) do
		point:guessed(p:compute(point:toArray()))
	end
	count = 0
end

function love.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end


	if love.keyboard.isDown('return') then
		for i,point in ipairs(points) do
			p:train(point:toArray(), point:test())
		end
		count = count + 1

		for i,point in ipairs(points) do
			point:guessed(p:compute(point:toArray()))
		end
	end

end

function love.draw(dt)
	for i,v in ipairs(points) do
		v:draw()
	end

	-- perceptron model line is => p.w[1]*x+p.w[2]*y+p.w[3] = 0
	-- so in form of a*x+b
	local a = - p.weights[1] / p.weights[2]
	local b = - p.weights[3] / p.weights[2] 
	local left_x  = 0
	local right_x = 1
	local left_y  = b + a * left_x
	local right_y = b + a * right_x

	love.graphics.setLineWidth(3)
	love.graphics.setColor({1,1,1})
	love.graphics.line( left_x, left_y*love.graphics.getHeight(), right_x*love.graphics.getWidth(), right_y*love.graphics.getHeight())

	love.graphics.print( count)


end