tests
testEndSymbol1
	self parse: '>' rule: #endSymbol.
	self
		assert: result
		equals:
			{DCUmlAggregationKind none.
			true}