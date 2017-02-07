building
defaultValue
	^ super defaultValue ==> [ :expression | OPFAMIXValueSpecification from: expression ]