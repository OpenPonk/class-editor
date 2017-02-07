tests
testEndSymbol1
	self parse: '>' rule: #endSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind none.
			true}