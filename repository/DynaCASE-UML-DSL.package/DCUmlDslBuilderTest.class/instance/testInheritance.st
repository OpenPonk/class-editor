tests
testInheritance
	self parse: 'Sub >> Super;' rule: #inheritance.
	self assert: result class equals: FAMIXInheritance.
	self assert: result subclass name equals: 'Sub'.
	self assert: result superclass name equals: 'Super'