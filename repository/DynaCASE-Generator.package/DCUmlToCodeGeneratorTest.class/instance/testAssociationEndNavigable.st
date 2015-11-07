tests
testAssociationEndNavigable
	| sourceCls |
	model := self unidirectionalAssociation.
	sourceCls := self newClassNamed: model source name.
	generator resolveAssociationEndFor: model targetEnd opposite: model sourceEnd.
	self
		assertCollection: sourceCls selectors
		hasSameElements: #(#elements #elements: #addElement: #removeElement: #initialize).
	self
		assert: (sourceCls >> #elements:) ast
		equals: (RBParser parseMethod: 'elements: aCollection elements := aCollection').
	self
		assert: (sourceCls >> #elements) ast
		equals:
			(RBParser
				parseMethod: 'elements <DCType: #TargetSomething name: ''elements>'' multiplicity: #(0 *)> ^ elements').
	self
		assert: (sourceCls >> #initialize) ast
		equals: (RBParser parseMethod: 'initialize super initialize. elements := OrderedCollection new')