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
print(type(x))

disk = 0 #where disk vs shell is drawn from the json
shell = 0
volume = 0 #just defining for now

# userInput = json.dumps(sys.argv)
userInput = json.dumps({"dependentVariable":"x","independentVariable":"y","integrationMethod":"disk","expression":"y","upperBound":"1","lowerBound":"0"})
#this turns it into a string
userInput = json.loads(userInput)
print(type(x))
print(userInput["independentVariable"])
print(type(userInput["independentVariable"]))
sympify(userInput["independentVariable"]) #i expect this to convert it to a sympy symbol object, but it persists as unicode. whyyyyy I can't interact w it that way
print(type(userInput["independentVariable"]))
x.subs(x, userInput["independentVariable"])
print(type(x))
print(x)
#bc oop/python
#i honestly can't beelieve that worked
#print(userInput["dependentVariable"]) #there we go, took long enough

# userInput["expression"]
#load from page (i have no actual idea how to take it from the page, but i should be able to match the json formatting)

# json.loads({"dependentVariable":"x","independentVariable":"y","integrationMethod":"disk","expression":"y","upperBound":"1","lowerBound":"0"}) #replace w wherever you get the json, for now has a dummy json

# expr = x**2

if (disk):
	volume = pi * integrate((x),x)  #okay this works, that squares the function and treats it symbolically, then evals the integral.
	#i'm using x here but this works with either x or y.
	print(volume) #this should be shiny for passing it to ruby

if (shell):
	print()
	#volume = 2*pi * integrate(S((firstFunc)*(secondFunc)),x) #okay this is possibl the impossibly difficult part. defining the function won't be easy, i don't think, wo presetting it. 

# i don't know if this is necessary, or if i can juts print it
# print(json.dumps({"volume":volume})) #it needs to not be a print statement, but to feed to the page.
