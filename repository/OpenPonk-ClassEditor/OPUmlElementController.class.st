"
I am a base class for diagram element controllers.
"
Class {
	#name : #OPUmlElementController,
	#superclass : #OPElementController,
	#traits : 'OPTUmlBaseController',
	#classTraits : 'OPTUmlBaseController classTrait',
	#instVars : [
		'diagramElement'
	],
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #forms }
OPUmlElementController >> applyStereotype: aStereotypeModel to: aModel [
	(aModel appliedStereotypes
		anySatisfy: [ :each | each umlClassName = aStereotypeModel umlClassName ])
		ifTrue: [ ^ self ].
	self removeStereotypesIn: aModel.
	aModel applyStereotype: aStereotypeModel implementationClass new
]

{ #category : #forms }
OPUmlElementController >> buildAbstractEditorForm: aForm [
	(aForm addCheckbox: 'Is Abstract')
		state: self model isAbstract;
		whenChangedDo: [ :val | 
			self model isAbstract: val.
			self refreshFigure ]
]

{ #category : #figures }
OPUmlElementController >> createDiagramElement [
	^ self subclassResponsibility
]

{ #category : #figures }
OPUmlElementController >> createFigure [
	^ self shouldNotImplement
]

{ #category : #forms }
OPUmlElementController >> descriptionStereotype [
	| profile names stereotypes |
	profile := self diagramController model profileApplications
		ifEmpty: [ ^ nil ]
		ifNotEmpty: [ :col | col first appliedProfile ].
	stereotypes := self stereotypesIn: profile for: self model.
	names := stereotypes asArray collect: [ :each | each name -> each name ].
	^ MASingleOptionDescription new
		optionsAndLabels: {nil -> ''} , names;
		accessor:
			(MAPluggableAccessor
				read: [ :me | 
					me model appliedStereotypes
						ifEmpty: [ nil ]
						ifNotEmpty: [ :col | col first umlClassName ] ]
				write: [ :me :newValue | 
					newValue
						ifNil: [ self removeStereotypesIn: me model ]
						ifNotNil: [ self
								applyStereotype: (stereotypes detect: [ :each | each name = newValue ])
								to: me model ].
					me refreshFigure.
					me refreshFigure ]);
		label: 'Stereotype';
		priority: 4;
		yourself
]

{ #category : #figures }
OPUmlElementController >> diagramElement [
	^ diagramElement
]

{ #category : #figures }
OPUmlElementController >> figure [
	^ self diagramElement rtElement
]

{ #category : #accessing }
OPUmlElementController >> magritteDescription [
	| container |
	container := MAPragmaBuilder for: self.
	container addAll: self stereotypeMagritteDescription.
	^ container
]

{ #category : #hooks }
OPUmlElementController >> reactToAttributeWrite [
	diagramElement ifNotNil: [ self refreshFigure ]
]

{ #category : #figures }
OPUmlElementController >> removeDiagramElement [
	self diagramController deselectAll.
	diagramElement view
		ifNotNil: [ 
			diagramElement remove.
			diagramElement := nil ]
]

{ #category : #figures }
OPUmlElementController >> removeFigure [
	self removeDiagramElement
]

{ #category : #model }
OPUmlElementController >> removeModel [
	self subclassResponsibility
	
]

{ #category : #removing }
OPUmlElementController >> removeStereotypesIn: aModel [
	[ aModel appliedStereotypes isNotEmpty ]
		whileTrue: [ aModel unapplyStereotype: aModel appliedStereotypes first ]
]

{ #category : #figures }
OPUmlElementController >> renderFigureIn: aView [
	self subclassResponsibility
]

{ #category : #accessing }
OPUmlElementController >> stereotypeMagritteDescription [
	| descriptions |
	descriptions := OPUmlStereotypeDescriptions new controller: self.
	^ descriptions descriptions
]

{ #category : #'as yet unclassified' }
OPUmlElementController >> stereotypesIn: aProfile for: aModel [
	^ (aProfile ownedStereotype reject: #isAbstract)
		select: [ :stereo | 
			stereo allAttributes
				anySatisfy: [ :each | (each name beginsWith: 'base_') and: [ self model oclIsKindOf: each type name ] ] ]
]
