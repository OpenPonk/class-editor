"
I am a controller for an Enumeration
"
Class {
	#name : #OPUmlEnumerationController,
	#superclass : #OPUmlElementController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #adding }
OPUmlEnumerationController >> addAsSourceFor: aController [
	aController source: self
]

{ #category : #adding }
OPUmlEnumerationController >> addAsTargetFor: aController [
	aController createModelIn: self andShowInDiagram: self diagramController
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
OPUmlEnumerationController >> allShowableElementsInModel: aClassModel [
	| queue |
	queue := OrderedCollection new.
	queue addAll: aClassModel ownedLiterals.
	^ queue asArray select: [ :each | diagramController hasSupportForModel: each ]
]

{ #category : #'events - registering' }
OPUmlEnumerationController >> attachTo: aDiagramController [
	| newModel |
	newModel := self createModel.
	OPRenameElementCommand executeOn: newModel.
	aDiagramController model packagedElements add: newModel.
	aDiagramController showModelInDiagram: newModel
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
OPUmlEnumerationController >> createModelIn: aPackageController andShowInDiagram: aDiagramController [
	self model: self createModel.
	aDiagramController model packagedElements add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController
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
OPUmlEnumerationController >> remove [
	(self allShowableElementsInModel: self model)
		do: [ :each | 
			diagramController controllers
				detect: [ :ctrl | ctrl model = each ]
				ifFound: [ :ctrl | ctrl remove ] ].
	super remove
]

{ #category : #removing }
OPUmlEnumerationController >> removeModel [
	| ownerModel |
	ownerModel := diagramController model.
	self remove.
	ownerModel packagedElements remove: self model
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

{ #category : #rendering }
OPUmlEnumerationController >> showInDiagram: aDiagramController [
	self renderFigureIn: aDiagramController view.
	(self allShowableElementsInModel: self model)
		do: [ :each | 
			| subCtrl |
			subCtrl := aDiagramController newControllerFor: each.
			aDiagramController addController: subCtrl.
			subCtrl showInDiagram: aDiagramController ]
]
