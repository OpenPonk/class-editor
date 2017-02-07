tests
testPrefix
	self parse: '/' rule: #prefix.
	self parse: '_' rule: #prefix.
	self parse: '/_' rule: #prefix.
	self parse: '_/' rule: #prefix