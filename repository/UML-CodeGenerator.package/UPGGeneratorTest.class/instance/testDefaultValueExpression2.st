tests
testDefaultValueExpression2
	(model := FAMIXAttribute named: 'numbers')
		multiplicity:
			OPFAMIXMultiplicity zeroToMany.
	self
		assert: (generator defaultValueExpressionFor: model)
		equals: 'OrderedCollection new'