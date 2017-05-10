*OpenPonk-ClassEditor
notationString
	^ String
		streamContents: [ :stream | 
			(OPUMLVisibilityKind notationFor: self visibility)
				ifNotEmpty: [ :v | 
					stream
						nextPutAll: v;
						nextPutAll: ' ' ].
			self flag: 'https://github.com/OpenPonk/uml-bootstrap-generator/issues/10'.
			self isDerived = true | (self isDerived = 'true')
				ifTrue: [ stream << '/' ].
			stream << self name.
			self type
				ifNotNil: [ stream
						<< ' : ';
						<< self type name.
					self notationMultiplicityRange
						ifNotEmpty: [ :range | stream nextPutAll: '[' , range , ']' ] ] ]