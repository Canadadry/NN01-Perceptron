require "Class"

PerceptronDefault = {minValue=-1,maxValue=1,numberOfInput=2,activation=function (x) return x>=0 and 1 or -1 end}



Perceptron = class()

function Perceptron:init(numberOfInput)
	self.weights = {}
	self.biais = self:random()
	local numberOfInput = numberOfInput or PerceptronDefault.numberOfInput
	for i=1, numberOfInput do
		self.weights[i] = self:random()
	end
end

function Perceptron:random()
	local amplitude =  PerceptronDefault.maxValue - PerceptronDefault.minValue
	local offset    = (PerceptronDefault.maxValue + PerceptronDefault.minValue)/2
	return math.random()*amplitude+offset
end


function Perceptron:compute(inputs)
	assert(inputs, "You must provide inputs to compute perceptron value")
	assert(#inputs == #self.weights,"inputs do not have the right length")
	local sum=self.biais
	for i=1,#inputs do
		sum = sum + inputs[i]*self.weights[i]
	end
	if self.activation then return self.activation(sum) end
	return PerceptronDefault.activation(sum)
end
