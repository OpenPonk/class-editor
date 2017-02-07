tests
testClassWithStereotype
	self parse: 'MyClass <<meta,class>> {}' rule: #classBlock.
	self assert: result class equals: FAMIXClass.
	self assert: result name equals: 'MyClass'.
	self assert: result stereotypes size equals: 2.
	self assert: result stereotypes first name equals: 'meta'.
	self assert: result stereotypes second name equals: 'class'