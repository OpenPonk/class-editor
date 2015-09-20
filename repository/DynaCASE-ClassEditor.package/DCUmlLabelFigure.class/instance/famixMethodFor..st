*DynaCASE-ClassEditor-FAMIX
famixMethodFor: aMethod
	^ String
		streamContents:
			[ :s | 
			s nextPutAll: aMethod name.
			s nextPut: $(.
			aMethod parameters do: [ :p | s nextPutAll: (self famixParameterFor: p) ].
			s nextPut: $).
			aMethod declaredType
				ifNotNil:
					[ 
					s
						nextPutAll: ' : ';
						nextPutAll: aMethod declaredType name;
						nextPutAll: aMethod multiplicity asOptionalString ] ]