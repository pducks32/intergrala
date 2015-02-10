#python backend for integrala
#takes JSON-formatted functions/x//y respects/disk//shell method and calculates an integral, then spits it back out as a JSON-formatted integral.
#CURRENTLY FUNCTIONING: 
#Disk Method
#TODO
#shell method
#actually getting the data and then spitting it back out again
#ensure it can actually parse a function in human-readable, as opposed to sympy-readable. possibly mitigate by converting all ^ in a string to **?
#note!!!!! ** = what your would expect ^ to do in sympy!

from sympy import *
import json
import sys

x = Symbol('x')
y = Symbol('y')

disk = 0
shell = 0
volume = 0 #just defining for now

userInput = json.dumps(sys.argv)
# userInput = json.dumps({"dependentVariable":"x","independentVariable":"y","integrationMethod":"disk","expression":"y","upperBound":"1","lowerBound":"0"})
#this turns it into a string
userInput = json.loads(userInput)
#above turns it into a python dict

x = Symbol(userInput["dependentVariable"])

if userInput["integrationMethod"] == "disk":
	disk = true
elif userInput["integrationMethod"] == "shell":
	print("Shell method is not yet implemented.")

if (disk):
	volume = pi * integrate((x)**2,(x,0,1))  #okay this works, that squares the function and treats it symbolically, then evals the integral.
	indefIntegral = pi * integrate((x)**2,x) #maybe you need this
	#i'm using x here but this works with either x or y.
	print(latex(volume)) #need print as latex

if (shell):
	volume = 2 * pi * integrate(x,x)
	#volume = 2*pi * integrate(S((firstFunc)*(secondFunc)),x) #okay this is possibl the impossibly difficult part. defining the function won't be easy, i don't think, wo presetting it. 
	print(latex(volume))

# i don't know if this is necessary, or if i can juts print it
# print(json.dumps({"volume":volume,"volumeExpression":volumeExpression}))
