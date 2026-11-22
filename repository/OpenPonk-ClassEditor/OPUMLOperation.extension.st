Extension { #name : 'OPUMLOperation' }

{ #category : '*OpenPonk-ClassEditor' }
OPUMLOperation >> notationString [

	^ String streamContents: [ :stream |
			  (OPUMLVisibilityKind notationFor: self visibility) ifNotEmpty: [ :visibilitySymbol |
					  stream nextPutAll: visibilitySymbol.
					  stream nextPutAll: ' ' ].
			  self name ifNotNil: [ :operationName | stream << operationName ].
			  stream << '('.
			  (self ownedParameters reject: [ :parameter | parameter direction = OPUMLParameterDirectionKind return ])
				  do: [ :parameter | stream << parameter notationString ]
				  separatedBy: [ stream << ', ' ].
			  stream << ')'.
			  self ownedParameters
				  detect: [ :parameter | parameter direction = OPUMLParameterDirectionKind return ]
				  ifFound: [ :returnParameter |
						  returnParameter type ifNotNil: [ :returnType |
								  returnType name ifNotNil: [ :typeName |
										  stream << ' : '.
										  stream << typeName.
										  returnParameter notationMultiplicityRange ifNotEmpty: [ :range |
												  stream nextPutAll: '['.
												  stream nextPutAll: range.
												  stream nextPutAll: ']' ] ] ] ] ]
]
