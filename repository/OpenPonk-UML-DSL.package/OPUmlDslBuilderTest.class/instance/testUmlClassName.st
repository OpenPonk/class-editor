tests
testUmlClassName
	self parse: 'Name' rule: #umlClassName.
	self assert: result equals: 'Name'