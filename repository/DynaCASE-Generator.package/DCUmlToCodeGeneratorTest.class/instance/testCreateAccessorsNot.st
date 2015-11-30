tests
testCreateAccessorsNot
	generator context withoutAccessors.
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	generator createAttributeFor: model in: cls.
	self assert: cls selectors equals: #()