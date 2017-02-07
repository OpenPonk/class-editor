tests
testLeftEndWithRole
	self parse: 'Left role -' rule: #leftEnd.
	self assert: result first equals: 'Left'.
	self assert: result second class equals: DCFAMIXProperty.
	self assert: result second name equals: 'role'.
	self assert: result third equals: DCUmlAggregationKind none.
	self assert: result fourth equals: false