*OpenPonk-ClassEditor
notationString
	^ String
		streamContents: [ :stream | 
			(OPUMLVisibilityKind notationFor: self visibility)
				ifNotEmpty: [ :v | 
					stream
						nextPutAll: v;
						nextPutAll: ' ' ].
			self isDerived
				ifTrue: [ stream << '/' ].
			stream << self name.
			self type
				ifNotNil: [ stream
						<< ' : ';
						<< self type name ].
			self notationMultiplicityRange
				ifNotEmpty: [ :range | stream nextPutAll: '[' , range , ']' ].
			(self defaultValue isKindOf: OPUMLOpaqueExpression)
				ifTrue: [ stream
						<< ' = ';
						<< self defaultValue bodies first ] ]