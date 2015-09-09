public
methodToString: aMethod
	^ aMethod name , '(' , (self parametersToString: aMethod parameters) , ')'