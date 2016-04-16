tests
testCreateCollectionAttribute
	(model := FAMIXAttribute named: 'numbers' type: (FAMIXClass named: 'Float'))
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	generator createAttributeFor: model in: cls.
	self assert: cls instVarNames equals: #(#numbers).
	self assert: cls classVarNames equals: #()