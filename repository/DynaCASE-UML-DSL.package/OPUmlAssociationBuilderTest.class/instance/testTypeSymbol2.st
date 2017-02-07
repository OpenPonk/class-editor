tests
testTypeSymbol2
	self parse: '<>' rule: #typeSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind shared.
			false}