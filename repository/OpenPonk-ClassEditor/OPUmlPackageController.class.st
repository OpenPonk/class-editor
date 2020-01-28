"
I am a controller for Package/Model/Profile
"
Class {
	#name : #OPUmlPackageController,
	#superclass : #OPUmlElementController,
	#instVars : [
		'modelClass'
	],
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #adding }
OPUmlPackageController >> addAsSourceFor: aController [
	aController source: self
]

{ #category : #adding }
OPUmlPackageController >> addAsTargetFor: aController [
	aController
		createModelIn: self model
		andShowInDiagram: self diagramController
]

{ #category : #rendering }
OPUmlPackageController >> allShowableElements [
	^ #()
]

{ #category : #'events - registering' }
OPUmlPackageController >> attachTo: aDiagramController [
	| newModel |
	newModel := self createModel.
	OPRenameElementCommand executeOn: newModel.
	aDiagramController model packagedElements add: newModel.
	aDiagramController showInDiagramModel: newModel
]

{ #category : #configuration }
OPUmlPackageController >> beForModel [
	modelClass := OPUMLModel
]

{ #category : #configuration }
OPUmlPackageController >> beForPackage [
	modelClass := OPUMLPackage
]

{ #category : #configuration }
OPUmlPackageController >> beForProfile [
	modelClass := OPUMLProfile
]

{ #category : #testing }
OPUmlPackageController >> canBeSourceFor: aController [
	^ aController isKindOf: OPUmlPackageImportController
]

{ #category : #testing }
OPUmlPackageController >> canBeTargetFor: aController [
	^ aController isKindOf: OPUmlPackageImportController
]

{ #category : #figures }
OPUmlPackageController >> createDiagramElement [
	^ OPUmlPackageCompartmentableShape new
		modelElement: self model;
		in: [ :shape | 
			shape style
				fillColor: Color white;
				fontColor: Color black ];
		yourself
]

{ #category : #construction }
OPUmlPackageController >> createModelIn: aParentModel [
	| newModel names |
	newModel := self modelClass new.
	names := {(OPUMLPackage -> 'Package').
	(OPUMLModel -> 'Model').
	(OPUMLProfile -> 'Profile')} asDictionary.
	newModel name: (names at: newModel class).
	self model: newModel.
	aParentModel packagedElements add: model.
	^ model
]

{ #category : #testing }
OPUmlPackageController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlPackageController >> modelClass [
	modelClass ifNil: [ self beForPackage ].
	^ modelClass
]

{ #category : #figures }
OPUmlPackageController >> refreshFigure [
	self diagramElement changed
]

{ #category : #removing }
OPUmlPackageController >> remove [
	self allShowableElements
		do: [ :each | 
			diagramController controllers
				detect: [ :ctrl | ctrl model = each ]
				ifFound: [ :ctrl | ctrl remove ] ].
	super remove
]

{ #category : #removing }
OPUmlPackageController >> removeModel [
	| ownerModel |
	ownerModel := diagramController model.
	self remove.
	ownerModel packagedElements remove: self model
]

{ #category : #rendering }
OPUmlPackageController >> renderFigureIn: aView [
	diagramElement := self createDiagramElement.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure.
"	self figure @ RTDraggable""SnapToGrid"
]
