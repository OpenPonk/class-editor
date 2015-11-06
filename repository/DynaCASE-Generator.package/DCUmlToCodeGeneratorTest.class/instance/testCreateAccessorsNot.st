tests
testCreateAccessorsNot
	generator withoutAccessors.
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	cls := Object subclass: #SomethingGenerated.
	generator createAttributeFor: model in: cls.
	self assert: cls selectors equals: #()