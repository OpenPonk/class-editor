Extension { #name : 'OPUMLProperty' }

{ #category : '*OpenPonk-ClassEditor' }
OPUMLProperty >> notationAssociationMultiplicityRange [
	^ (sharedGeneralizations at: #MultiplicityElement) notationAssociationMultiplicityRange
]

{ #category : '*OpenPonk-ClassEditor' }
OPUMLProperty >> notationMultiplicityRange [
	^ (sharedGeneralizations at: #MultiplicityElement) notationMultiplicityRange
]

{ #category : '*OpenPonk-ClassEditor' }
OPUMLProperty >> notationString [

	^ String streamContents: [ :stream |
			  | propertyModifiers |
			  (OPUMLVisibilityKind notationFor: self visibility) ifNotEmpty: [ :visibilitySymbol |
					  stream nextPutAll: visibilitySymbol.
					  stream nextPutAll: ' ' ].
			  self isDerived ifTrue: [ stream << '/' ].
			  self name ifNotNil: [ :propertyName | stream << propertyName ].
			  self type ifNotNil: [ :propertyType |
					  propertyType name ifNotNil: [ :typeName |
							  stream << ' : '.
							  stream << typeName ] ].
			  self notationMultiplicityRange ifNotEmpty: [ :range |
					  stream nextPutAll: '['.
					  stream nextPutAll: range.
					  stream nextPutAll: ']' ].
			  ((self defaultValue isKindOf: OPUMLOpaqueExpression) and: [ self defaultValue bodies isNotEmpty ]) ifTrue: [
					  stream << ' = '.
					  stream << self defaultValue bodies first ].
			  propertyModifiers := OrderedCollection new.
			  self isReadOnly ifTrue: [ propertyModifiers add: #readOnly ].
			  self isOrdered ifTrue: [ propertyModifiers add: #ordered ].
			  (self isMultivalued and: [ self isUnique not ]) ifTrue: [ propertyModifiers add: #nonunique ].
			  propertyModifiers ifNotEmpty: [
					  stream << ' {'.
					  propertyModifiers do: [ :each | stream << each ] separatedBy: [ stream << ', ' ].
					  stream << '}' ] ]
]

{ #category : '*OpenPonk-ClassEditor' }
OPUMLProperty >> notationStringAsRoleName [

	^ String streamContents: [ :stream | 
		  (OPUMLVisibilityKind notationFor: self visibility) ifNotEmpty: [ 
			  :v | 
			  stream
				  nextPutAll: v;
				  nextPutAll: ' ' ].
		  self isDerived ifTrue: [ stream << '/' ].
		  self name ifNotNil: [ stream << self name ].

		  ((self defaultValue isKindOf: OPUMLOpaqueExpression) and: [ 
			   self defaultValue bodies isNotEmpty ]) ifTrue: [ 
			  stream
				  << ' = ';
				  << self defaultValue bodies first ].
		  true ifTrue: [ 
			  | props |
			  props := OrderedCollection new.
			  self isReadOnly ifTrue: [ props add: #readOnly ].
			  self isOrdered ifTrue: [ props add: #ordered ].
			  self isMultivalued & self isUnique not ifTrue: [ 
				  props add: #nonunique ].
			  props ifNotEmpty: [ 
				  stream << ' {'.
				  props
					  do: [ :each | stream << each ]
					  separatedBy: [ stream << ', ' ].
				  stream << '}' ] ] ]
]
