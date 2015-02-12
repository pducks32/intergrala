#python backend for integrala
#takes JSON-formatted functions/x//y respects/disk//shell method and calculates an integral, then spits it back out as a JSON-formatted integral.
#CURRENTLY FUNCTIONING:
#Disk Method
#T0DO...SORRY BUNDLER CHECKS FOR T0DO MESSAGES AND RAISES AN ERROR :(
#shell method
#actually getting the data and then spitting it back out again
#ensure it can actually parse a function in human-readable, as opposed to sympy-readable. possibly mitigate by converting all ^ in a string to **?
#note!!!!! ** = what your would expect ^ to do in sympy!

from sympy import *
import json
import sys

disk = 0
shell = 0
volume = 0 #just defining for now

#{"dependentVariable":"x","independentVariable":"y","integrationMethod":"disk","expression":"y","upperBound":"1","lowerBound":"0"}

def myMethod(data):
	userInput = data;
	dependent = Symbol(userInput["dependentVariable"])

	transformations = standard_transformations + (convert_xor,)
	expression = parse_expr(userInput["expression"], transformations = transformations)

	intergrationMethod = userInput["integrationMethod"]
	upperBound = userInput["upperBound"]
	lowerBound = userInput["lowerBound"]

	if(intergrationMethod == "disk"):
		latexString = latex(pi * integrate((expression)**2,(dependent, lowerBound, upperBound)))  #okay this works, that squares the function and treats it symbolically, then evals the integral.
		volume = pi * integrate((expression)**2,(dependent, lowerBound, upperBound))
	elif method == "shell":
		sys.exit(15) # So my progarm can tell why it failed and fail gracefully. 15 bc Go Class of '15'!
		# Won't get called
		volume = 2 * pi * integrate(expression,(dependent, lowerBound, upperBound))
		#volume = 2*pi * integrate(S((firstFunc)*(secondFunc)),x) #okay this is possibl the impossibly difficult part. defining the function won't be easy, i don't think, wo presetting it.


	return {volume: volume, latex: latexString};

sys.stdout.write(json.dump( myMethod( json.loads(sys.argv[1]))))
