*DynaCASE-ClassEditor-FAMIX
umlSignature
	^ String
		streamContents:
			[ :s | 
			s nextPutAll: self name.
			s nextPut: $(.
			s nextPutAll: ((self parameters collect: #umlSignature) joinUsing: ', ').
			s nextPut: $).
			self declaredType
				ifNotNil:
					[ s
						nextPutAll: ' : ';
						nextPutAll: self declaredType name;
						nextPutAll: self multiplicity asOptionalString ] ]