tests
testGetterPragma2
	| pragma |
	(model := FAMIXAttribute named: 'string') multiplicity: DCFAMIXMultiplicity zeroToMany.
	pragma := generator getterPragmaFor: model.
	self assert: pragma equals: '<DCType: #Object multiplicity: #(0 *)>'