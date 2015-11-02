generators
getterPragmaFor: aFamixAttribute
	| typeName |
	typeName := self typeNameFor: aFamixAttribute declaredType.
	^ String
		streamContents:
			[ :stream | 
			stream nextPutAll: '<DCType: #'.
			stream nextPutAll: typeName.
			aFamixAttribute multiplicity
				ifNotNil:
					[ :mul | 
					stream nextPutAll: ' '.
					stream nextPutAll: 'multiplicity: '.
					stream nextPutAll: '#('.
					stream nextPutAll: mul printLower.
					mul lower = mul upper
						ifFalse: [ stream
								nextPutAll: ' ';
								nextPutAll: mul printUpper ].
					stream nextPutAll: ')' ].
			stream nextPutAll: '>' ]