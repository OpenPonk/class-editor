tests
testGetterPragma
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	self
		assert: (generator getterPragmaFor: model)
		equals: (Pragma keyword: #DCType:multiplicity: arguments: #(#String #(1)))