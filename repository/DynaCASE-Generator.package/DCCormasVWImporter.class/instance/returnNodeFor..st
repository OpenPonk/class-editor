as yet unclassified
returnNodeFor: aMethod
	| ast |
	ast := aMethod sourceAnchor pharoEntity ast.
	self assert: [ ast lastIsReturn ].
	^ ast body statements last value