Class {
	#name : #LIVLiveInstanceVisualization,
	#superclass : #Object,
	#category : 'LiveInstanceVisualization'
}

{ #category : #'as yet unclassified' }
LIVLiveInstanceVisualization class >> wipExample [
	| m dir f doc els edges v |
	m
		ifNil: [ dir := FileLocator D / 'prog' / 'normalized-systems'.
			f := dir / 'branchBankingCompV2-1.0.xml'.
			doc := XMLDOMParser parse: f contents.
			m := NSPXMLInterchange new importFromDocument: doc ].
	els := LIVLiveInstanceVisualization new shapesFor: m.
	edges := els value.
	els := els key.
	v := RTView new.
	els
		do: [ :each | 
			each renderIn: v.
			each rtElement @ RTDraggable ].
	edges do: [ :each | each renderIn: v ].

	"RTHorizontalTreeLayout on: (els collect: #rtElement)."
	RTRadialTreeLayout new
		horizontalGap: 300;
		verticalGap: 400;
		on: (els collect: #rtElement).

	"el rtElement @ RTResizable @ RTDraggable."
	v @ RTDraggableView @ RTZoomableView
]

{ #category : #shapes }
LIVLiveInstanceVisualization >> baseShapeFor: anObject named: aString [
	| el |
	el := OPUmlClassifierShape new.
	OPUmlNameLabel new
		text: aString;
		localStyle: (OPUmlStyle new fontSize: 11; fontUnderline: true);
		owningElement: el.
	el modelElement: anObject.
	^ el
]

{ #category : #'as yet unclassified' }
LIVLiveInstanceVisualization >> isReferenceValue: aValue of: anObject [
	aValue class package = anObject class package
		ifTrue: [ ^ true ].
	(aValue isCollection
		and: [ aValue isNotEmpty and: [ aValue anyOne class package = anObject class package ] ])
		ifTrue: [ ^ true ].
	^ false
]

{ #category : #shapes }
LIVLiveInstanceVisualization >> labelFor: aKey withText: text [
	^ OPUmlLabel new
		text: text;
		modelElement: aKey;
		yourself
]

{ #category : #'as yet unclassified' }
LIVLiveInstanceVisualization >> limitedShapeFor: anObject [
	| el comp |
	el := self baseShapeFor: anObject named: anObject name , ' : ' , anObject class name.
	comp := OPUmlCompartment new.
	comp owningElement: el.
	#(id , name)
		select: [ :each | anObject class hasInstVarNamed: each ]
		thenDo: [ :key | 
			| text |
			text := key , (self textFor: (anObject instVarNamed: key) of: anObject).
			(self labelFor: key withText: text) owningElement: comp ].
	^ el
]

{ #category : #'as yet unclassified' }
LIVLiveInstanceVisualization >> referenceShapeFrom: aSourceShape to: aTargetShape [
	^ OPUmlEdge new
		source: aSourceShape;
		target: aTargetShape;
		modelElement: aSourceShape modelElement -> aTargetShape modelElement;
		yourself
]

{ #category : #'as yet unclassified' }
LIVLiveInstanceVisualization >> shapeFor: anObject [
	| el comp values |
	el := self baseShapeFor: anObject named: anObject name , ' : ' , anObject class name.
	comp := OPUmlCompartment new.
	comp owningElement: el.
	values := self valuesOf: anObject.
	values keysAndValuesDo: [ :key :value |
			| text |
			text := key , (self textFor: value of: anObject).
			(self labelFor: value withText: text) owningElement: comp ].
	values associations
		select: [ :pair | self isReferenceValue: pair value of: anObject ]
		thenDo: [ :pair | 
			comp ownedElements
				detect: [ :each | each modelElement = pair value ]
				ifFound: [ :each | each localStyle: (OPUmlStyle new fontColor: Color blue) ] ].
	^ el
]

{ #category : #'as yet unclassified' }
LIVLiveInstanceVisualization >> shapesFor: anObject [
	| primaryShape referencedObjects values secondaryShapes references ref refObjects refCollections |
	values := self valuesOf: anObject.
	ref := values associations
		select: [ :pair | self isReferenceValue: pair value of: anObject ].
	refObjects := ref reject: [ :pair | pair value isCollection ] thenCollect: #value.
	refCollections := (ref select: [ :pair | pair value isCollection ]) flatCollect: #value.
	primaryShape := self shapeFor: anObject.
	references := RTGroup new.
	secondaryShapes := RTGroup new.
	refObjects
		collect: [ :each | 
			| shape |
			shape := self shapeFor: each.
			secondaryShapes add: shape.
			references add: (self referenceShapeFrom: primaryShape to: shape) ].
	refCollections
		collect: [ :each | 
			| shape |
			shape := self limitedShapeFor: each.
			secondaryShapes add: shape.
			references add: (self referenceShapeFrom: primaryShape to: shape) ].
	^ (secondaryShapes , {primaryShape}) -> references
]

{ #category : #'as yet unclassified' }
LIVLiveInstanceVisualization >> textFor: aValue of: anObject [
	aValue class package = anObject class package
		ifTrue: [ ^ ' = ' , aValue class name ].
	(aValue isCollection
		and: [ aValue isNotEmpty and: [ aValue anyOne class package = anObject class package ] ])
		ifTrue: [ ^ ' : ' , aValue anyOne class name , '[*]', ' = an ' , aValue class name, '()' ].
	^ ' = ' , aValue printString
]

{ #category : #'as yet unclassified' }
LIVLiveInstanceVisualization >> valuesOf: anObject [
	^ (anObject class instanceVariables sorted
		collect: [ :each | each -> (anObject instVarNamed: each) ]) asOrderedDictionary
]
