Class {
	#name : #LIVInstanceModel,
	#superclass : #Object,
	#instVars : [
		'name',
		'elements',
		'history'
	],
	#category : 'LiveInstanceVisualization-Models'
}

{ #category : #adding }
LIVInstanceModel >> addLinkFrom: sourceObject to: targetObject at: aSlot [
	((self ensureInstanceFor: sourceObject) slots at: aSlot)
		add: (self ensureInstanceFor: targetObject)
]

{ #category : #'roassal - drawing' }
LIVInstanceModel >> addMenuFor: aFigure [
	| menu |
	menu := PluggableMenuSpec new model: aFigure.
	menu
		add: 'Remove'
		target: aFigure
		selector: #remove
		argumentList: #().
	aFigure rtElement when: TRMouseRightClick do: [ :event | menu asMenuMorph popUpInWorld ]
]

{ #category : #accessing }
LIVInstanceModel >> elements [
	^ elements
]

{ #category : #accessing }
LIVInstanceModel >> elementsLinkingTo: anInstance [
	^ elements
		select: [ :each | 
			each slots associations
				anySatisfy: [ :assoc | 
					assoc value isCollection
						ifTrue: [ assoc value includes: anInstance ]
						ifFalse: [ assoc value = anInstance ] ] ]
]

{ #category : #adding }
LIVInstanceModel >> ensureInstanceFor: anObject [
	^ self
		specificationFor: anObject
		ifAbsentPut: [ history specificationBuilder instanceOn: anObject ]
]

{ #category : #'inspector - extensions' }
LIVInstanceModel >> gtInspectorModelViewIn: composite [
	<gtInspectorPresentationOrder: -1>
	composite roassal2
		title: '[LIV] Instance Model';
		initializeView: [ | v |
			v := RTView new.
			self renderIn: v.
			self showDiffIn: v.
			v @ RTDraggableView @ RTZoomableView.
			v ]
]

{ #category : #accessing }
LIVInstanceModel >> history [
	^ history
]

{ #category : #accessing }
LIVInstanceModel >> history: anObject [
	history := anObject
]

{ #category : #initialization }
LIVInstanceModel >> initialize [
	super initialize.
	elements := OrderedCollection new
]

{ #category : #removing }
LIVInstanceModel >> removeInstance: anInstance [
	(self elementsLinkingTo: anInstance) ifNotEmpty: [ ^ self ].
	elements remove: anInstance
]

{ #category : #removing }
LIVInstanceModel >> removeLinkFrom: sourceObject to: targetObject at: aSlot [
	| source target |
	source := self specificationFor: sourceObject ifNone: [ ^ self ].
	target := self specificationFor: targetObject ifNone: [ ^ self ].
	(source slots at: aSlot) remove: target.
	self removeInstance: target
]

{ #category : #removing }
LIVInstanceModel >> removeLinksFrom: sourceObject at: aSlot [
	| source removed |
	source := self specificationFor: sourceObject ifNone: [ ^ self ].
	removed := source slots at: aSlot.
	removed isCollection
		ifTrue: [ removed := removed copy.
			(source slots at: aSlot) removeAll.
			removed do: [ :each | self removeInstance: each ] ]
		ifFalse: [ source slots at: aSlot put: nil.
			self removeInstance: removed ]
]

{ #category : #'roassal - drawing' }
LIVInstanceModel >> renderIn: aView [
	| shapes |
	shapes := (elements collect: #asShape) asGroup.
	shapes
		do: [ :each | 
			each renderIn: aView.
			each rtElement when: TRMouseLeftClick do: [ :evt |  ].
			self addMenuFor: each.
			each rtElement @ RTResizable @ RTDraggable ].
	shapes do: [ :each | self renderShape: each fromShapes: shapes in: aView ].
	RTHorizontalFlowLayout new
		gapSize: 50;
		on: shapes
]

{ #category : #'roassal - drawing' }
LIVInstanceModel >> renderShape: aShape fromShapes: aCollection in: aView [
	| pairs |
	pairs := OrderedCollection new.
	aShape modelElement slots
		associationsDo: [ :pair | 
			(pair value isKindOf: LIVInstanceSpecification)
				ifTrue: [ pairs add: pair key -> pair value ].
			(pair value isCollection and: [ pair value allSatisfy: [ :each | each isKindOf: LIVInstanceSpecification ] ])
				ifTrue: [ pair value do: [ :each | pairs add: pair key -> each ] ] ].
	pairs
		do: [ :pair | 
			| key value |
			key := pair key.
			value := pair value.
			aCollection
				detect: [ :each | each modelElement instanceHash = value instanceHash ]
				ifFound: [ :target | 
					| edge |
					edge := OPUmlAssociationEdge new
						source: aShape;
						target: target;
						targetLabel:
							(OPUmlNameLabel new
								text: key asString;
								modelElement: key);
						modelElement: aShape modelElement -> key;
						headDecorator: RTSimpleArrow;
						yourself.
					edge renderIn: aView ]
				ifNone: [ OPUmlTypedElementLabel new
						owningElement: aShape;
						modelElement: key;
						text:
							(String
								streamContents: [ :stream | 
									stream << key.
									stream << ' = ' << value printString ]) ] ]
]

{ #category : #adding }
LIVInstanceModel >> setLinkFrom: sourceObject to: targetObject at: aSlot [
	(self ensureInstanceFor: sourceObject) slots
		at: aSlot
		put: (self ensureInstanceFor: targetObject)
]

{ #category : #adding }
LIVInstanceModel >> setValueFrom: aSourceObject to: aTargetObject at: aSlot [
	(self ensureInstanceFor: aSourceObject) slots at: aSlot put: aTargetObject
]

{ #category : #'roassal - drawing' }
LIVInstanceModel >> showDiffIn: aView [
	history ifNil: [ ^ self ].
	(history models before: self ifAbsent: [ nil ])
		ifNotNil: [ :old | 
			| diff colorer |
			diff := LIVInstanceModelDiff new diffBetween: old and: self.
			colorer := LIVInstanceDiffColorer new.
			colorer colorAll: diff in: aView ]
]

{ #category : #accessing }
LIVInstanceModel >> specificationFor: anObject [
	^ elements detect: [ :each | each instanceHash = anObject hash ]
]

{ #category : #accessing }
LIVInstanceModel >> specificationFor: anObject ifAbsentPut: aBlock [
	^ elements
		detect: [ :each | each instanceHash = anObject hash ]
		ifNone: [ | value |
			value := aBlock value.
			elements add: value.
			value ]
]

{ #category : #accessing }
LIVInstanceModel >> specificationFor: anObject ifNone: aBlock [
	^ elements detect: [ :each | each instanceHash = anObject hash ] ifNone: aBlock
]

{ #category : #removing }
LIVInstanceModel >> unsetLinkFrom: sourceObject at: aSlot [
	| source removed |
	source := self specificationFor: sourceObject ifNone: [ ^ self ].
	removed := source slots at: aSlot.
	source slots at: aSlot put: nil.
	self removeInstance: removed
]
