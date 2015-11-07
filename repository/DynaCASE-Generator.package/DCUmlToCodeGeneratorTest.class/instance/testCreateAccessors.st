tests
testCreateAccessors
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	generator createAttributeFor: model in: cls.
	self assert: cls selectors equals: #(#string: #string).
	self
		assert: (cls >> #string:) ast
		equals: (RBParser parseMethod: 'string: aString string := aString').
	self
		assert: (cls >> #string) ast
		equals: (RBParser parseMethod: 'string <DCType: #String multiplicity: #(1)> ^ string')