tests
testAssociationEndNonNavigable
	| targetCls |
	model := self unidirectionalAssociation.
	targetCls := self newClassNamed: model target name.
	generator resolveAssociationEndFor: model sourceEnd opposite: model targetEnd.
	self assert: targetCls instVarNames equals: #().
	self assert: targetCls selectors equals: #(#owner).
	self
		assert: (targetCls >> #owner) ast
		equals:
			(RBParser
				parseMethod: 'owner <DCType: #SourceSomething name: ''elements>'' multiplicity: #(1)> <DCNonNavigable> ^ self shouldNotImplement')