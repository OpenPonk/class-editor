tests
testOpName2
	self parse: 'op:name:' rule: #opName.
	self assert: result equals: 'op:name:'