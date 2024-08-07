Extension { #name : 'OPUMLParameter' }

{ #category : '*OpenPonk-ClassEditor' }
OPUMLParameter >> notationMultiplicityRange [
	^ (sharedGeneralizations at: #MultiplicityElement) notationMultiplicityRange
]

{ #category : '*OpenPonk-ClassEditor' }
OPUMLParameter >> notationString [
	^ String
		streamContents: [ :stream | 
			({OPUMLParameterDirectionKind inout.
			OPUMLParameterDirectionKind out} includes: self direction)
				ifTrue: [ stream
						<< (self direction splitOn: '::') last;
						<< ' ' ].
			stream << self name.
			self type
				ifNotNil: [ stream
						<< ' : ';
						<< self type name ].
			self notationMultiplicityRange
				ifNotEmpty: [ :range | 
					stream
						<< '[';
						<< range;
						<< ']' ]
			"			(self defaultValue isKindOf: OPUMLOpaqueExpression)
				ifTrue: [ stream
						<< ' = ';
						<< self defaultValue bodies first ]" ]
]
