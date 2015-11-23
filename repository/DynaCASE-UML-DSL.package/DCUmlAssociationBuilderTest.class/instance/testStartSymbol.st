tests
testStartSymbol
	self parse: '<*>' rule: #startSymbol.
	self
		assert: result
		equals:
			{DCUmlAggregationKind composite.
			false}