tests
testCreateCollectionAccessors
	generator context useEagerInitialization.
	(model := FAMIXAttribute named: 'numbers' type: (FAMIXClass named: 'Float'))
		multiplicity: DCFAMIXMultiplicity zeroToMany.
	generator createAttributeFor: model in: cls.
	self
		assertCollection: cls selectors
		hasSameElements: #(#numbers #numbers: #addNumber: #removeNumber: #initialize).
	self assert: cls selectors size equals: 5.
	self
		assert: (cls >> #numbers:) ast
		equals: (RBParser parseMethod: 'numbers: aCollection numbers := aCollection').
	self
		assert: (cls >> #numbers) ast
		equals: (RBParser parseMethod: 'numbers <DCType: #Float multiplicity: #(0 *)> ^ numbers').
	self
		assert: (cls >> #addNumber:) ast
		equals: (RBParser parseMethod: 'addNumber: aFloat numbers add: aFloat').
	self
		assert: (cls >> #removeNumber:) ast
		equals: (RBParser parseMethod: 'removeNumber: aFloat numbers remove: aFloat').
	self
		assert: (cls >> #initialize) ast
		equals: (RBParser parseMethod: 'initialize super initialize. numbers := OrderedCollection new')