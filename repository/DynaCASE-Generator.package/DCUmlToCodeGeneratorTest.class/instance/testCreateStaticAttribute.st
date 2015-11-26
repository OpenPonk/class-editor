tests
testCreateStaticAttribute
	(model := FAMIXAttribute named: 'something' type: (FAMIXClass named: 'String'))
		isStatic: true.
	generator createAttributeFor: model in: cls.
	self assert: cls instVarNames equals: #().
	self assert: cls classVarNames equals: #().
	self assert: cls class instVarNames equals: #(#something)