require "Perceptron"

math.randomseed( os.time() )

p = Perceptron(4)
print(p:compute({1,2,3,4}))
