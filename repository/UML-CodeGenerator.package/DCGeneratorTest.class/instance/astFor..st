utilities
astFor: aMethodExpression
	aMethodExpression isString
		ifTrue: [ ^ RBParser parseMethod: aMethodExpression ].
	aMethodExpression isCompiledMethod
		ifTrue: [ aMethodExpression ast ].
	^ aMethodExpression