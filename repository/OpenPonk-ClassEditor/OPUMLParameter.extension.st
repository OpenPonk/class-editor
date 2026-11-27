Extension { #name : 'OPUMLParameter' }

{ #category : '*OpenPonk-ClassEditor' }
OPUMLParameter >> notationMultiplicityRange [
	^ (sharedGeneralizations at: #MultiplicityElement) notationMultiplicityRange
]

{ #category : '*OpenPonk-ClassEditor' }
OPUMLParameter >> notationString [

	^ String streamContents: [ :stream |
			  ({
				   OPUMLParameterDirectionKind inout.
				   OPUMLParameterDirectionKind out } includes: self direction) ifTrue: [
					  stream << (self direction splitOn: '::') last.
					  stream << ' ' ].
			  self name ifNotNil: [ :parameterName | stream << parameterName ].
			  self type ifNotNil: [ :parameterType |
					  parameterType name ifNotNil: [ :typeName |
							  stream << ' : '.
							  stream << typeName ] ].
			  self notationMultiplicityRange ifNotEmpty: [ :range |
					  stream << '['.
					  stream << range.
					  stream << ']' ] ]
]
