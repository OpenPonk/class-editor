tests
testStartSymbol
	self parse: '<*>' rule: #startSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind composite.
			false}