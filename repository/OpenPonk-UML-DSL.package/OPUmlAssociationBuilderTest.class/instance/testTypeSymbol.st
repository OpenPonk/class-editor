tests
testTypeSymbol
	self parse: '-' rule: #typeSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind none.
			false}