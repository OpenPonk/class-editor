tests
testAssociationPragma
	model := self unidirectionalAssociation.
	self
		assert: (generator associationPragmaFor: model targetEnd)
		equals:
			(Pragma
				keyword: #DCType:role:name:multiplicity:
				arguments:
					{#TargetSomething.
					'elements'.
					'elements>'.
					#(0 #*)})