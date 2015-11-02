*DynaCASE-ClassEditor-FAMIX
umlSignature
	^ String
		streamContents:
			[ :s | 
			s nextPutAll: self name.
			self declaredType
				ifNotNil:
					[ :type | 
					s
						nextPutAll: ' : ';
						nextPutAll: type name;
						nextPutAll: self multiplicity asOptionalString ] ]