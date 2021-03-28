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
	aDiagramController showWithoutDependentInDiagramModel: newModel
]

{ #category : #configuration }
OPUmlPackageController >> beForModel [
	modelClass := OPUMLPackage
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

{ #category : #accessing }
OPUmlPackageController >> dependentElements [
	| mainElementTypes |
	mainElementTypes := {#Class . #Package . #Enumeration . #Profile.
	#Model}.
	^ (self model packagedElements
		select:
			[ :each | mainElementTypes anySatisfy: [ :any | each oclIsKindOf: any ] ])
		asSet , self model packageImports
		,
			((diagramController model packagedElements
				select: [ :each | 
					{#Package . #Profile . #Model}
						anySatisfy: [ :any | each oclIsKindOf: any ] ])
				flatCollectAsSet: [ :eachPackagedElement | 
					eachPackagedElement packageImports
						select: [ :eachImport | eachImport importingNamespace = self model ] ])
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
	self diagramElement changed.
	^ self figure
]

{ #category : #removing }
OPUmlPackageController >> removeModel [
	diagramController model packagedElements remove: self model
]

{ #category : #rendering }
OPUmlPackageController >> renderFigureIn: aView [
	self diagramController addingFigureFor: self.
	diagramElement := self createDiagramElement.
	diagramElement renderIn: aView.
	diagramController addedFigureFor: self.
	^ self refreshFigure
]
