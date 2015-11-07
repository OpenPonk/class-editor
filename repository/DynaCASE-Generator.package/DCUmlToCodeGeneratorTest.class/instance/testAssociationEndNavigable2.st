tests
testAssociationEndNavigable2
	| targetCls |
	model := self unidirectionalAssociation.
	model sourceEnd beNavigable.
	targetCls := self newClassNamed: model target name.
	generator resolveAssociationEndFor: model sourceEnd opposite: model targetEnd.
	self assert: targetCls instVarNames equals: #(#owner).
	self assertCollection: targetCls selectors hasSameElements: #(#owner #owner:).
	self
		assert: (targetCls >> #owner:) ast
		equals: (RBParser parseMethod: 'owner: aSourceSomething owner := aSourceSomething').
	self
		assert: (targetCls >> #owner) ast
		equals:
			(RBParser
				parseMethod: 'owner <DCType: #SourceSomething name: ''elements>'' multiplicity: #(1)> ^ owner')