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
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #configuration }
OPUmlAssociationShape >> addConstraintsTo: aCollection at: aPosition [
	aCollection add: (self constraintLabel: nameLabel at: aPosition side: -1).
	aCollection add: (self constraintLabel: propertiesLabel at: #center side: 0).
	aCollection add: (self constraintLabel: stereotypeLabel at: aPosition side: 1).
]

{ #category : #configuration }
OPUmlAssociationShape >> constraintLabel: aLabel at: aPosition side: aSide [
	| config anchor |
	config := Dictionary
		with: #source -> (Array with: 10 with: aSide * 10)
		with: #target -> (Array with: -10 with: aSide * 10)
		with: #middle -> (Array with: 0.5 with: aSide * 10)
		with: #center -> (Array with: 0.5 with: 0).
	anchor := OPRTAnchorConstraint new.
	anchor
		element: aLabel rtElement;
		edge: self rtEdge;
		balance: (config at: aPosition) first;
		minDistance: (config at: aPosition) second.
	^ anchor
]

{ #category : #accessing }
OPUmlAssociationShape >> decoratorFor: aProperty [
	(self ontoUmlDecoratorFor: aProperty) ifNotNil: [ :marker | ^ marker ].
	aProperty opposite aggregation = OPUMLAggregationKind composite
		ifTrue: [ ^ OPUmlEdgeMarkers filledDiamond ].
	aProperty opposite aggregation = OPUMLAggregationKind shared
		ifTrue: [ ^ OPUmlEdgeMarkers emptyDiamond ].
	aProperty isNavigable & aProperty opposite isNavigable
		ifTrue: [ ^ OPUmlEdgeMarkers none ].
	aProperty isNavigable & aProperty opposite isNavigable not
		ifTrue: [ ^ OPUmlEdgeMarkers simpleArrow ].
	^ OPUmlEdgeMarkers none
]

{ #category : #accessing }
OPUmlAssociationShape >> endLabelsClass [
	^ OPUmlAssociationEndLabels
]

{ #category : #'Roassal2 - updating' }
OPUmlAssociationShape >> ends: anArray [
	| ends |
	ends := anArray.
	ends first modelElement = sourceEndLabels modelElement type
		ifFalse: [ ends := ends reverse ].
	self source: ends first.
	self target: ends second
]

{ #category : #initialization }
OPUmlAssociationShape >> initialize [
	super initialize.
	(nameLabel := OPUmlNameLabel new)
		text: [ :model | 
			(model isDerived
				ifTrue: [ '/' ]
				ifFalse: [ '' ]) , (model name ifNil: [ '' ]) ];
		owningElement: self.
	(propertiesLabel := OPUmlLabel new)
		text: [ :model | 
			(self propertiesOfModel: model)
				ifEmpty: [ '' ]
				ifNotEmpty: [ :props | '{' , (props joinUsing: ',') , '}' ] ];
		owningElement: self.
	(stereotypeLabel := OPUmlNameLabel new)
		text: [ :model | 
			model appliedStereotypes
				ifEmpty: [ '' ]
				ifNotEmpty: [ :s | '«' , ((s collect: #umlClassName) joinUsing: ',') , '»' ] ];
		owningElement: self.
	sourceEndLabels := self endLabelsClass on: self.
	targetEndLabels := self endLabelsClass on: self.
	constraints := OrderedCollection new
]

{ #category : #accessing }
OPUmlAssociationShape >> modelElement: aModel [
	super modelElement: aModel.
	nameLabel modelElement: aModel.
	propertiesLabel modelElement: aModel.
	stereotypeLabel modelElement: aModel.
	sourceEndLabels modelElement: aModel memberEnds first.
	targetEndLabels modelElement: aModel memberEnds second
]

{ #category : #accessing }
OPUmlAssociationShape >> ontoUmlDecoratorFor: aProperty [
	| stereoNames markers |
	stereoNames := aProperty association appliedStereotypes collect: #umlClassName.
	markers := {#SubQuantityOf -> (OPUmlEdgeMarkers filledDiamondWith: 'Q').
	#SubCollectionOf -> (OPUmlEdgeMarkers filledDiamondWith: 'C').
	#MemberOf -> (OPUmlEdgeMarkers emptyDiamondWith: 'M').
	#ComponentOf -> (OPUmlEdgeMarkers emptyDiamondWith: 'C')} asDictionary.
	aProperty opposite aggregation = OPUMLAggregationKind composite
		ifTrue: [ (stereoNames includes: #SubQuantityOf)
				ifTrue: [ ^ markers at: #SubQuantityOf ].
			(stereoNames includes: #SubCollectionOf)
				ifTrue: [ ^ markers at: #SubCollectionOf ] ].
	aProperty opposite aggregation = OPUMLAggregationKind shared
		ifTrue: [ (stereoNames includes: #MemberOf)
				ifTrue: [ ^ markers at: #MemberOf ].
			(stereoNames includes: #ComponentOf)
				ifTrue: [ ^ markers at: #ComponentOf ] ].
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

{ #category : #rendering }
OPUmlAssociationShape >> renderIn: aView [
	super renderIn: aView.
	self addConstraintsTo: constraints at: #middle.
	sourceEndLabels addConstraintsTo: constraints at: #source.
	targetEndLabels addConstraintsTo: constraints at: #target.
	self ownedElements do: [ :each | each renderIn: view ].
	constraints do: #build.
	self update
]

{ #category : #'Roassal2 - updating' }
OPUmlAssociationShape >> update [
	self
		tailDecorator: (self decoratorFor: modelElement memberEnds first).
	self
		headDecorator: (self decoratorFor: modelElement memberEnds second).
	self rtEdge shape color: self style strokeColor.
	self rtEdge view ifNotNil: [ self rtEdge update ].
	constraints do: #update.
	self ownedElements do: #update
]
