package.path = package.path .. ";../src/?.lua"
package.path = package.path .. ";Love2d/?.lua"
require "Perceptron"
require "Point"
local inspect = require "inspect"

math.randomseed( os.time() )

p = Perceptron(3)
p.weights[1] = 1
p.weights[2] = 1
p.weights[3] = 1

-- lets make a simple test with four point so it is easy to follow
-- y
-- |                         
-- |    p3(1,2)    p4(2,2)                 
-- |                         
-- |                         
-- |                         
-- |                         
-- |    p1(1,1)     p2(2,1)                
-- |                         
-- |--------------------------- x

-- test it with y = 1.5 so we should converge to w3/w2 = 1.5 and w1 = 0

Point.test = function ( self )
	local a = 0
	local b = 1.5
	return  (a*self.x +b) > self.y-- y = a*x+b
end

pts = { }
pts[1] = Point({1,1})
pts[2] = Point({2,1})
pts[3] = Point({1,2})
pts[4] = Point({2,2})

-- print(inspect(pts,{depth=2}))

function p_point(debug)
	for i,v in ipairs(pts) do
		debug.str = debug.str .. "p" .. i ..":"..p:compute({v.x,v.y,1}) .. "  "
	end
end
function p_weights( debug )
	for i,v in ipairs(p.weights) do
		debug.str = debug.str .. "w" .. i ..":"..v .. "  "
	end
end

function step( i , debug)
	debug.str = i .. " " .. (i%4+1) .. " "
	pt = pts[i%4+1]
	p:train({pt.x,pt.y,1},pt:test() and 1 or -1,debug)
end


for i=0,30 do
	local debug = { str = ""}
	step(i,debug)
	p_weights(debug)
	print(debug.str)
end




