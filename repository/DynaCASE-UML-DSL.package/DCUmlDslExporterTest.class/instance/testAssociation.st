tests
testAssociation
	self export: (self parseAssociation: 'Left --> Right;') equals: 'Left --> Right;'