tests
testRightEndWithRole
	self parse: '- role Right' rule: #rightEnd.
	self assert: result first equals: 'Right'.
	self assert: result second class equals: DCFAMIXAssociationEnd.
	self assert: result second name equals: 'role'.
	self assert: result third equals: false