transforming
methodFor: aMethod
	^ (self entityFor: aMethod)
		isStatic: aMethod isStatic;
		yourself