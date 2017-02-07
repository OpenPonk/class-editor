tests
testLeftEnd
	self parse: 'Left -' rule: #leftEnd.
	self assert: result first equals: 'Left'.
	self assert: result second class equals: DCFAMIXProperty.
	self assert: result second name equals: nil.
	self assert: result third equals: DCUmlAggregationKind none.
	self assert: result fourth equals: false