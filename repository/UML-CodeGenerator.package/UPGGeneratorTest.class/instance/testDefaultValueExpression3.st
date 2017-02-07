tests
testDefaultValueExpression3
	| expression |
	expression := '#(1 2 3)'.
	(model := FAMIXAttribute named: 'numbers')
		multiplicity: OPFAMIXMultiplicity oneToMany;
		defaultValue: (OPFAMIXValueSpecification from: expression).
	self assert: (generator defaultValueExpressionFor: model) equals: expression