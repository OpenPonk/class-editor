*DynaCASE-ClassEditor-FAMIX
famixParameterFor: aParameter
	^ String
		streamContents:
			[ :s | 
			s nextPutAll: aParameter name.
			aParameter declaredType
				ifNotNil:
					[ :type | 
					s
						nextPutAll: ' : ';
						nextPutAll: type name;
						nextPutAll: aParameter multiplicity asOptionalString ] ]