converting
famixTextFor: anAttribute
	^ String
		streamContents: [ :stream | 
			anAttribute visibility
				ifNotNil: [ :v | stream nextPut: (OPUmlVisibilityKind toSymbol: v) ].
			stream nextPutAll: anAttribute name.
			anAttribute hasDeclaredType
				ifTrue: [ stream
						nextPutAll: ' : ';
						nextPutAll: anAttribute declaredType name;
						nextPutAll: anAttribute multiplicity asOptionalString ].
			anAttribute defaultValue
				ifNotNil: [ :v | 
					stream
						nextPutAll: ' = ';
						nextPutAll: v valueExpression asString ].
			anAttribute unit
				ifNotNil: [ :v | 
					stream
						nextPutAll: ' {';
						nextPutAll: v;
						nextPutAll: '}' ] ]