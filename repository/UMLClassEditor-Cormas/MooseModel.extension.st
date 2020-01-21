Extension { #name : #MooseModel }

{ #category : #'*UMLClassEditor-Cormas' }
MooseModel >> isCormasModel [
	<MSEProperty: #isCormasModel type: #Boolean>
	<MSEComment: 'Does this MooseModel represent a Cormas model?'>
	^ self privateState propertyAt: #isCormasModel ifAbsentPut: [ false ]
]

{ #category : #'*UMLClassEditor-Cormas' }
MooseModel >> isCormasModel: aBoolean [
	^ self privateState propertyAt: #isCormasModel put: aBoolean
]
