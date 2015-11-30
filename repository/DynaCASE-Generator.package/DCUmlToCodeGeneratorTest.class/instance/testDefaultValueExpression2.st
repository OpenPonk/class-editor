tests
testDefaultValueExpression2
	(model := FAMIXAttribute named: 'numbers') multiplicity: DCFAMIXMultiplicity zeroToMany.
	self assert: (generator defaultValueExpressionFor: model) equals: 'OrderedCollection new'