"
An edge shape representing a UML association. Renders connection lines, navigability markers, and coordinates placement of end labels.
"
Class {
	#name : 'OPUmlAssociationShape',
	#superclass : 'OPUmlEdge',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'initialization' }
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

{ #category : 'initialization' }
OPUmlAssociationShape >> createOwnedElementsWithoutController [
	self ownedElements ifNotEmpty: [ ^ self ].
	{
		OPUmlAssociationLabel.
		OPUmlAssociationStereotypesLabel } do: [ :each | each in: self ].

	self createEndLabels
]

{ #category : 'Roassal2 - accessing' }
OPUmlAssociationShape >> headMarker [

	^ self markerShapeFor:
		  (self modelElement ifNil: [ ^ nil ]) memberEnds second
]

{ #category : 'accessing' }
OPUmlAssociationShape >> markerShapeFor: aProperty [

	(self ontoUmlDecoratorFor: aProperty) ifNotNil: [ :marker | ^ marker ].
	aProperty opposite aggregation = OPUMLAggregationKind composite 
		ifTrue: [ ^ OPRSMarkerBuilder diamond ].
	aProperty opposite aggregation = OPUMLAggregationKind shared ifTrue: [ 
		^ OPRSMarkerBuilder diamond asEmptyMarker ].
	aProperty isNavigable ifTrue: [ ^ OPRSMarkerBuilder arrow ].
	^ nil
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
OPUmlAssociationShape >> propertiesOfModel: aModelElement [
	^ (OPUmlAssociationLabel new modelElement: aModelElement) properties
]

{ #category : 'testing' }
OPUmlAssociationShape >> supportsHidingLabelEnds [

	^ true
]

{ #category : 'Roassal2 - accessing' }
OPUmlAssociationShape >> tailMarker [

	^ self markerShapeFor:
		  (self modelElement ifNil: [ ^ nil ]) memberEnds first
]
