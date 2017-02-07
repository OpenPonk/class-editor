tests
testDefaultValueExpression
	(model := FAMIXAttribute named: 'numbers')
		multiplicity:
			OPFAMIXMultiplicity zeroToOne.
	self assert: (generator defaultValueExpressionFor: model) equals: nil