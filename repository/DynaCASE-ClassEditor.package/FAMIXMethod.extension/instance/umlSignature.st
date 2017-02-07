*DynaCASE-ClassEditor-FAMIX
umlSignature
	^ String
		streamContents: [ :s | 
			self visibility ifNotNil: [ :v | s nextPut: (OPUmlVisibilityKind toSymbol: v) ].
			s nextPutAll: self name.
			s nextPut: $(.
			(self parameters
				reject: [ :each | each direction = OPUmlParameterDirectionKind return ])
				do: [ :each | s nextPutAll: each umlSignature ]
				separatedBy: [ s nextPutAll: ', ' ].
			s nextPut: $).
			self parameters
				detect: [ :each | each direction = OPUmlParameterDirectionKind return ]
				ifFound: [ :param | 
					param declaredType name ~= 'Object' | (param multiplicity lower ~= 1)
						| (self multiplicity upper ~= 1)
						ifTrue: [ s
								nextPutAll: ' : ';
								nextPutAll: param declaredType name;
								nextPutAll: param multiplicity asOptionalString ] ] ]