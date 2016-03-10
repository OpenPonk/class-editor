*DynaCASE-ClassEditor-FAMIX
umlSignature
	^ String
		streamContents: [ :s | 
			s nextPutAll: self name.
			s nextPut: $(.
			s nextPutAll: ((self parameters collect: #umlSignature) joinUsing: ', ').
			s nextPut: $).
			(self declaredType isNotNil
				and: [ self declaredType name ~= 'Object' | (self multiplicity lower ~= 1)
						| (self multiplicity upper ~= 1) ])
				ifTrue: [ s
						nextPutAll: ' : ';
						nextPutAll: self declaredType name;
						nextPutAll: self multiplicity asOptionalString ] ]