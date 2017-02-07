tests
testLeftEndWithRole
	self parse: 'Left role -' rule: #leftEnd.
	self assert: result first equals: 'Left'.
	self assert: result second class equals: OPFAMIXProperty.
	self assert: result second name equals: 'role'.
	self assert: result third equals: OPUmlAggregationKind none.
	self assert: result fourth equals: false