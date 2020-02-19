"
I am a controller for an Enumeration
"
Class {
	#name : #OPUmlEnumerationController,
	#superclass : #OPUmlElementController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #adding }
OPUmlEnumerationController >> addAsTargetFor: aController [
	aController
		createModelIn: self model
		andShowInDiagram: self diagramController
]

{ #category : #figures }
OPUmlEnumerationController >> adornments [
	^ {OPUmlIcons literalIcon
		-> [ | tool |
			tool := OPCreationTool new
				palette: self diagramController editor paletteModel;
				factory: [ OPUMLEnumerationLiteral new ].
			self diagramController editor paletteModel selectTool: tool.
			tool
				whenCompleted: [ :ctrl | 
					OPRenameElementCommand executeOn: ctrl model.
					ctrl refreshFigure ].
			tool targetSelected: self ]}
]

{ #category : #rendering }
OPUmlEnumerationController >> allShowableElements [
	| queue |
	queue := OrderedCollection new.
	queue addAll: self model ownedLiterals.
	^ queue asArray
		select: [ :each | diagramController hasSupportForModel: each ]
]

{ #category : #'events - registering' }
OPUmlEnumerationController >> attachTo: aDiagramController [
	| newModel |
	newModel := self createModel.
	OPRenameElementCommand executeOn: newModel.
	aDiagramController model packagedElements add: newModel.
	aDiagramController showWithoutDependentInDiagramModel: newModel
]

{ #category : #adding }
OPUmlEnumerationController >> canBeSourceFor: aController [
	^ aController isKindOf: OPUmlAssociationController
]

{ #category : #adding }
OPUmlEnumerationController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPUmlEnumerationLiteralController)
		| (aController isKindOf: OPUmlAssociationController)
]

{ #category : #figures }
OPUmlEnumerationController >> createDiagramElement [
	^ OPUmlClassShape new
		modelElement: self model;
		stereotype: [ #(enumeration) ]
]

{ #category : #model }
OPUmlEnumerationController >> createModel [
	^ self modelClass new
		name: 'Enumeration';
		yourself
]

{ #category : #construction }
OPUmlEnumerationController >> createModelIn: aParentModel [
	self
		model:
			(self modelClass new
				name: 'Enumeration';
				yourself).
	aParentModel packagedElements add: model.
	^ model
]

{ #category : #figures }
OPUmlEnumerationController >> elementsToShowInside [
	^ self model ownedLiterals asSet
]

{ #category : #testing }
OPUmlEnumerationController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlEnumerationController >> modelClass [
	^ OPUMLEnumeration
]

{ #category : #figures }
OPUmlEnumerationController >> refreshFigure [
	self diagramElement changed
]

{ #category : #removing }
OPUmlEnumerationController >> removeModel [
	diagramController model packagedElements remove: self model
]

{ #category : #figures }
OPUmlEnumerationController >> renderFigureIn: aView [
	diagramElement := self createDiagramElement.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self figure @ (OPRTUmlAdornments new adornments: self adornments).
	self refreshFigure.
	self figure @ RTDraggable
]
