tests
testGetterPragma2
	(model := FAMIXAttribute named: 'string') multiplicity: DCFAMIXMultiplicity zeroToMany.
	self
		assert: (generator getterPragmaFor: model)
		equals: (Pragma keyword: #DCType:multiplicity: arguments: #(#Object #(0 #*)))