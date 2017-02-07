building
defaultValue
	^ super defaultValue ==> [ :expression | DCFAMIXValueSpecification from: expression ]