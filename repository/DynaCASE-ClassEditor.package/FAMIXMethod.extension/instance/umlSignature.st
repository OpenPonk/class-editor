*DynaCASE-ClassEditor-FAMIX
umlSignature
	^ String
		streamContents: [ :s | 
			s nextPutAll: self name.
			s nextPut: $(.
			(self parameters
				reject: [ :each | each direction = DCUmlParameterDirectionKind return ])
				do: [ :each | s nextPutAll: each umlSignature ]
				separatedBy: [ s nextPutAll: ', ' ].
			s nextPut: $).
			self parameters
				detect: [ :each | each direction = DCUmlParameterDirectionKind return ]
				ifFound: [ :param | 
					param declaredType name ~= 'Object' | (param multiplicity lower ~= 1)
						| (self multiplicity upper ~= 1)
						ifTrue: [ s
								nextPutAll: ' : ';
								nextPutAll: param declaredType name;
								nextPutAll: param multiplicity asOptionalString ] ] ]