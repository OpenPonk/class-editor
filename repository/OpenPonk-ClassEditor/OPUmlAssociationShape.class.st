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
OPUmlAssociationShape >> createOwnedElementsWithoutController [

	super createOwnedElementsWithoutController.
	{ 
		OPUmlAssociationLabel.
		OPUmlAssociationPropertiesLabel.
		OPUmlAssociationStereotypesLabel } do: [ :each | 
		each in: self forModelElement: self modelElement ].

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

{ #category : #hooks }
OPUmlAssociationShape >> headMarker [

	^ self markerFor: self modelElement memberEnds second
]

{ #category : #accessing }
OPUmlAssociationShape >> markerFor: aProperty [

	(self ontoUmlDecoratorFor: aProperty) ifNotNil: [ :marker | ^ marker ].
	aProperty opposite aggregation = OPUMLAggregationKind composite 
		ifTrue: [ ^ OPUmlEdgeMarkers filledDiamond ].
	aProperty opposite aggregation = OPUMLAggregationKind shared ifTrue: [ 
		^ OPUmlEdgeMarkers emptyDiamond ].
	aProperty isNavigable ifTrue: [ ^ OPUmlEdgeMarkers simpleArrow ].
	^ OPUmlEdgeMarkers none
]

{ #category : #accessing }
OPUmlAssociationShape >> ontoUmlDecoratorFor: aProperty [

	| stereoNames markerTexts |
	stereoNames := aProperty association appliedStereotypes collect:
		               #umlClassName.
	markerTexts := { 
		               (#SubQuantityOf -> 'Q').
		               (#SubCollectionOf -> 'C').
		               (#MemberOf -> 'M') } asDictionary.
	aProperty opposite aggregation = OPUMLAggregationKind composite 
		ifTrue: [ 
			stereoNames do: [ :each | 
				markerTexts
					at: each
					ifPresent: [ :text | ^ OPUmlEdgeMarkers filledDiamondWith: text ] ] ].
	aProperty opposite aggregation = OPUMLAggregationKind shared ifTrue: [ 
		stereoNames do: [ :each | 
			markerTexts
				at: each
				ifPresent: [ :text | ^ OPUmlEdgeMarkers emptyDiamondWith: text ] ] ].
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

	^ self markerFor: self modelElement memberEnds first
]
