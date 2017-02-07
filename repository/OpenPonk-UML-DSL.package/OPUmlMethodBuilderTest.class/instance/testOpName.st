tests
testOpName
	self parse: 'op' rule: #opName.
	self assert: result equals: 'op'