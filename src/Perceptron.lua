require "Class"

PerceptronDefault = {
	minValue=-1,
	maxValue=1,
	numberOfInput=2,
	activation=function (x) return x>=0 and 1 or -1 end,
	-- activation=function (x) return 2/(1+math.exp(-x)-1) end,
	learningRate = 0.001
}



Perceptron = class()

function Perceptron:init(numberOfInput)
	self.weights = {}
	self.weights_retained = {}
	local numberOfInput = numberOfInput or PerceptronDefault.numberOfInput
	for i=1, numberOfInput do
		self.weights[i] = self.random()
		self.weights_retained[i] = 0
	end
end

function Perceptron.random()
	local amplitude =  PerceptronDefault.maxValue - PerceptronDefault.minValue
	local offset    = (PerceptronDefault.maxValue + PerceptronDefault.minValue)/2
	return math.random()*amplitude-amplitude/2+offset
end


function Perceptron:compute(inputs)
	assert(inputs, "You must provide inputs to compute perceptron value")
	assert(#inputs == #self.weights,"inputs do not have the right length")
	local sum=0
	for i=1,#inputs do
		sum = sum + inputs[i]*self.weights[i]
	end
	return PerceptronDefault.activation(sum)
end

function Perceptron:train( inputs,output,debug )
	assert(inputs, "You must provide inputs to compute perceptron value")
	assert(#inputs == #self.weights,"inputs do not have the right length")

	local guess = self:compute(inputs)
	local delta = output - guess

	for  k,v in ipairs(self.weights) do
		self.weights[k] = self.weights[k] + delta * inputs[k] * PerceptronDefault.learningRate
	end

end

