tests
testRightEndWithRole
	self parse: '- role Right' rule: #rightEnd.
	self parse: '> role Right[*]' rule: #rightEnd