converting
famixTextFor: anAttribute
	^ anAttribute name
		,
			(anAttribute hasDeclaredType
				ifTrue: [ ' : ' , anAttribute declaredType name
						, anAttribute multiplicity asOptionalString ]
				ifFalse: [ '' ])
		,
			(anAttribute defaultValue ifNil: [ '' ] ifNotNil: [ :v | ' = ' , v valueExpression ])