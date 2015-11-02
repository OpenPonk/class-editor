tests
testGetterPragma
	| pragma |
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	pragma := generator getterPragmaFor: model.
	self assert: pragma equals: '<DCType: #String multiplicity: #(1)>'