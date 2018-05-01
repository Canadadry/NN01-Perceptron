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
		point:guessed(p:compute({point.x,point.y,1}))
	end
	count = 0

end

function love.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end


	if love.keyboard.isDown('return') then
		--train
		-- p:train_init()
		for i,point in ipairs(points) do
			p:train({point.x,point.y,1}, point:test())
			-- p:train_retain({point.x,point.y,1}, point:test())
		end
		-- p:train_apply()
		count = count + 1

		local a = - p.weights[1] / p.weights[2]
		local b = - p.weights[3] / p.weights[2]	
		print(a .. "," ..b)

		for i,point in ipairs(points) do
			point:guessed(p:compute({point.x,point.y,1}))
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
	local right_x = love.graphics.getWidth()
	local left_y  = b + a * left_x
	local right_y = b + a * right_x

	love.graphics.setLineWidth(3)
	love.graphics.setColor({1,1,1})
	love.graphics.line( left_x, left_y, right_x, right_y )

	love.graphics.print( "count " .. count)


end