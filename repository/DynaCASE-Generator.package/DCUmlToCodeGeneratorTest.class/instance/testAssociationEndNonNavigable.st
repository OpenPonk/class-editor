tests
testAssociationEndNonNavigable
	| targetCls |
	model := self unidirectionalAssociation.
	targetCls := self newClassNamed: model target name.
	generator resolveAssociationEndFor: model sourceEnd opposite: model targetEnd.
	self assert: targetCls instVarNames equals: #().
	self assert: targetCls selectors equals: #()