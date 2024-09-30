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
		  (OPUMLVisibilityKind notationFor: self visibility) ifNotEmpty: [ 
			  :v | 
			  stream
				  nextPutAll: v;
				  nextPutAll: ' ' ].
		  self isDerived ifTrue: [ stream << '/' ].
		  self name ifNotNil: [ stream << self name ].
		  self type ifNotNil: [ 
			  stream
				  << ' : ';
				  << self type name ].
		  self notationMultiplicityRange ifNotEmpty: [ :range | 
			  stream nextPutAll: '[' , range , ']' ].
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
