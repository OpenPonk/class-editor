tests
testStartSymbol1
	self parse: '<' rule: #startSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind none.
			true}