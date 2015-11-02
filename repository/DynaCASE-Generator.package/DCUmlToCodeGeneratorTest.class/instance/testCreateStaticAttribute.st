tests
testCreateStaticAttribute
	(model := FAMIXAttribute named: 'something' type: (FAMIXClass named: 'String'))
		isStatic: true.
	cls := Object subclass: #SomethingGenerated.
	generator createAttributeFor: model in: cls.
	self assert: cls instVarNames equals: #().
	self assert: cls classVarNames equals: #(#something)