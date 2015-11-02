tests
testCreateCollectionAccessors
	(model := FAMIXAttribute named: 'numbers' type: (FAMIXClass named: 'Float'))
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	cls := Object subclass: #SomethingGenerated.
	generator createAttributeFor: model in: cls.
	self
		assertCollection: cls selectors
		hasSameElements: #(#numbers #numbers: #addNumber: #removeNumber: #initialize).
	self assert: cls selectors size equals: 5.
	self
		assert: (cls >> #numbers:) ast
		equals:
			(RBParser parseMethod: 'numbers: aFloatCollection numbers := aFloatCollection').
	self
		assert: (cls >> #numbers) ast
		equals:
			(RBParser parseMethod: 'numbers <DCType: #Float multiplicity: #(0 *)> ^ numbers').
	self
		assert: (cls >> #initialize) ast
		equals:
			(RBParser parseMethod: 'initialize super initialize. numbers := OrderedCollection new')