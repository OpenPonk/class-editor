tests
testDefaultValueExpression
	(model := FAMIXAttribute named: 'numbers') multiplicity: DCFAMIXMultiplicity zeroToOne.
	self assert: (generator defaultValueExpressionFor: model) equals: nil