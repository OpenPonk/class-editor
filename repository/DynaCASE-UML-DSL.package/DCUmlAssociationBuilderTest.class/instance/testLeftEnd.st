tests
testLeftEnd
	self parse: 'Left -' rule: #leftEnd.
	self assert: result first equals: 'Left'.
	self assert: result second class equals: DCFAMIXAssociationEnd.
	self assert: result second name equals: nil.
	self assert: result third equals: false