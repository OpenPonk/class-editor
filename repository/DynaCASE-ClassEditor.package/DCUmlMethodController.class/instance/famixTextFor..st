converting
famixTextFor: aMethod
	^ String
		streamContents:
			[ :s | 
			s nextPutAll: aMethod name.
			s nextPut: $(.
			s
				nextPutAll:
					((aMethod parameters collect: [ :p | self famixParameterFor: p ]) joinUsing: ', ').
			s nextPut: $).
			aMethod declaredType
				ifNotNil:
					[ 
					s
						nextPutAll: ' : ';
						nextPutAll: aMethod declaredType name;
						nextPutAll: aMethod multiplicity asOptionalString ] ]