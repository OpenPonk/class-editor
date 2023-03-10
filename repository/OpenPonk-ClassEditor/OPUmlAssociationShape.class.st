"
I am a shape composition to accomodate for the most common UML Association shape.
"
Class {
	#name : #OPUmlAssociationShape,
	#superclass : #OPUmlEdge,
	#instVars : [
		'nameLabel',
		'sourceEndLabels',
		'targetEndLabels',
		'constraints',
		'stereotypeLabel',
		'propertiesLabel'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #initialization }
OPUmlAssociationShape >> createEndLabels [

	{ 
		OPUmlAssociationEndLabel.
		OPUmlMultiplicityLabel } do: [ :each | 
		(each in: self forModelElement: self modelElement memberEnds first)
			atSource ].
	{ 
		OPUmlAssociationEndLabel.
		OPUmlMultiplicityLabel } do: [ :each | 
		each in: self forModelElement: self modelElement memberEnds second ]
]

{ #category : #initialization }
OPUmlAssociationShape >> createOwnedElementsWithoutController [

	super createOwnedElementsWithoutController.
	{ 
		OPUmlAssociationLabel.
		OPUmlAssociationPropertiesLabel.
		OPUmlAssociationStereotypesLabel } do: [ :each | each in: self ].

	self createEndLabels
]

{ #category : #hooks }
OPUmlAssociationShape >> headMarker [

	^ self markerShapeFor:
		  (self modelElement ifNil: [ ^ nil ]) memberEnds second
]

{ #category : #accessing }
OPUmlAssociationShape >> markerShapeFor: aProperty [

	(self ontoUmlDecoratorFor: aProperty) ifNotNil: [ :marker | ^ marker ].
	aProperty opposite aggregation = OPUMLAggregationKind composite 
		ifTrue: [ ^ OPRSMarkerBuilder diamond ].
	aProperty opposite aggregation = OPUMLAggregationKind shared ifTrue: [ 
		^ OPRSMarkerBuilder diamond asEmptyMarker ].
	aProperty isNavigable ifTrue: [ ^ OPRSMarkerBuilder arrow ].
	^ nil
]

{ #category : #accessing }
OPUmlAssociationShape >> ontoUmlDecoratorFor: aProperty [

	| stereoNames markerLetters |
	stereoNames := aProperty association appliedStereotypes collect:
		               #umlClassName.
	markerLetters := { 
		                 (#SubQuantityOf -> $Q).
		                 (#SubCollectionOf -> $C).
		                 (#MemberOf -> $M) } asDictionary.
	aProperty opposite aggregation = OPUMLAggregationKind composite 
		ifTrue: [ 
			stereoNames do: [ :each | 
				markerLetters
					at: each
					ifPresent: [ :letter | 
					^ OPRSMarkerBuilder diamondWithLetter: letter ] ] ].
	aProperty opposite aggregation = OPUMLAggregationKind shared ifTrue: [ 
		stereoNames do: [ :each | 
			markerLetters at: each ifPresent: [ :letter | 
				^ (OPRSMarkerBuilder diamondWithLetter: letter) asEmptyMarker ] ] ].
	^ nil
]

{ #category : #initialization }
OPUmlAssociationShape >> propertiesOfModel: aModel [
	| props |
	props := OrderedCollection new.
	aModel appliedStereotypes
		do: [ :stereo | 
			| meta |
			meta := stereo umlMetaClass.
			meta allAttributes reject: [ :attr | attr name beginsWith: 'base_' ]
				thenDo: [ :attr | 
					(stereo perform: attr name asSymbol)
						ifNotNil: [ :value | 
							value = true
								ifTrue: [ props add: attr name ]
								ifFalse: [ value = false
										ifFalse: [ props add: attr name , '=' , attr value asString ] ] ] ] ].
	^ props
]

{ #category : #hooks }
OPUmlAssociationShape >> tailMarker [

	^ self markerShapeFor:
		  (self modelElement ifNil: [ ^ nil ]) memberEnds first
]
