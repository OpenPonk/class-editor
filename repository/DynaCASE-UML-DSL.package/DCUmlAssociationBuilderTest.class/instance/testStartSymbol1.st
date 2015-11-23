tests
testStartSymbol1
	self parse: '<' rule: #startSymbol.
	self
		assert: result
		equals:
			{DCUmlAggregationKind none.
			true}