require "Class"

Perceptron = class({minValue=-1,maxValue=1,defaultNumberOfInput=2})

function Perceptron:init(numberOfInput)
	self.weights = {}
	self.biais = self:random()
	local numberOfInput = numberOfInput or self.defaultNumberOfInput
	for i=1, numberOfInput do
		self.weights[i] = self:random()
	end
end

function Perceptron:random()
	local amplitude =  self.maxValue - self.minValue
	local offset    = (self.maxValue + self.minValue)/2
	return math.random()*amplitude+offset
end


function Perceptron:compute(inputs)
	assert(inputs, "You must provide inputs to compute perceptron value")
	assert(#inputs == #self.weights,"inputs do not have the right length")
	local sum=self.biais
	for i=1,#inputs do
		sum = sum + inputs[i]*self.weights[i]
	end
	return sum
end
