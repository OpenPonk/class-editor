tests
testRightEnd
	self parse: '- Right' rule: #rightEnd.
	self assert: result first equals: 'Right'.
	self assert: result second class equals: OPFAMIXProperty.
	self assert: result second name equals: nil.
	self assert: result third equals: OPUmlAggregationKind none.
	self assert: result fourth equals: false