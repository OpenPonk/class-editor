"
I am a controller for a Class(ifier)
"
Class {
	#name : #OPUmlClassController,
	#superclass : #OPUmlElementController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #adding }
OPUmlClassController >> addAsSourceFor: aController [
	aController source: self
]

{ #category : #adding }
OPUmlClassController >> addAsTargetFor: aController [
	aController createModelIn: self andShowInDiagram: self diagramController
]

{ #category : #figures }
OPUmlClassController >> adornments [
	^ {OPUmlIcons attributeIcon
		-> [ | tool |
			tool := OPCreationTool new
				palette: self diagramController editor paletteModel;
				factory: [ OPUmlAttributeController new ].
			self diagramController editor paletteModel selectTool: tool.
			tool
				whenCompleted: [ :ctrl | 
					OPRenameElementCommand executeOn: ctrl model.
					ctrl refreshFigure ].
			tool targetSelected: self ].
	OPUmlIcons directedAssociationIcon
		-> [ | tool |
			tool := OPConnectionCreationTool new
				palette: self diagramController editor paletteModel;
				factory: [ OPUmlAssociationController new ].
			self diagramController editor paletteModel selectTool: tool.
			tool sourceSelected: self ].
	OPUmlIcons generalizationIcon
		-> [ | tool |
			tool := OPConnectionCreationTool new
				palette: self diagramController editor paletteModel;
				factory: [ OPUmlGeneralizationController new ].
			self diagramController editor paletteModel selectTool: tool.
			tool sourceSelected: self ]}
]

{ #category : #rendering }
OPUmlClassController >> allShowableElementsInModel: aClassModel [
	| queue |
	queue := OrderedCollection new.
	queue addAll: aClassModel ownedAttributes.
	queue addAll: aClassModel ownedOperations.
	^ queue asArray select: [ :each | diagramController hasSupportForModel: each ]
]

{ #category : #'events - registering' }
OPUmlClassController >> attachTo: aDiagramController [
	| newModel |
	newModel := self createModel.
	OPRenameElementCommand executeOn: newModel.
	aDiagramController model packagedElements add: newModel.
	aDiagramController showModelInDiagram: newModel
]

{ #category : #forms }
OPUmlClassController >> buildAbstractEditorForm: aForm [
	(aForm addCheckbox: 'Is Abstract')
		state: self model isAbstract;
		whenChangedDo: [ :val | 
			self model isAbstract: val.
			self refreshFigure ]
]

{ #category : #adding }
OPUmlClassController >> canBeSourceFor: aController [
	^ (aController isKindOf: OPUmlGeneralizationController)
		| (aController isKindOf: OPUmlAssociationController)
		| (aController isKindOf: OPUmlExtensionController)
]

{ #category : #adding }
OPUmlClassController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPUmlAttributeController)
		| (aController isKindOf: OPUmlOperationController)
		| (aController isKindOf: OPUmlGeneralizationController)
		| (aController isKindOf: OPUmlAssociationController)
		| (aController isKindOf: OPUmlExtensionController)
]

{ #category : #figures }
OPUmlClassController >> createDiagramElement [
	^ OPUmlClassShape new
		stereotype: [ self stereotypeNames ];
		modelElement: self model
]

{ #category : #model }
OPUmlClassController >> createModel [
	^ self modelClass new
		name: 'Class';
		yourself
]

{ #category : #construction }
OPUmlClassController >> createModelIn: aPackageController andShowInDiagram: aDiagramController [
	self model: self createModel.
	aDiagramController model packagedElements add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController
]

{ #category : #forms }
OPUmlClassController >> descriptionIsAbstract [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isAbstract);
		label: 'Is Abstract';
		priority: 5;
		yourself
]

{ #category : #forms }
OPUmlClassController >> descriptionStereotype [
	<magritteDescription>
	^ super descriptionStereotype
]

{ #category : #accessing }
OPUmlClassController >> modelClass [
	^ OPUMLClass
]

{ #category : #figures }
OPUmlClassController >> refreshFigure [
	self diagramElement changed
]

{ #category : #removing }
OPUmlClassController >> remove [
	(self allShowableElementsInModel: self model)
		do: [ :each | 
			diagramController controllers
				detect: [ :ctrl | ctrl model = each ]
				ifFound: [ :ctrl | ctrl remove ] ].
	super remove
]

{ #category : #removing }
OPUmlClassController >> removeModel [
	| ownerModel connectedAssociations connectedGeneralizations |
	ownerModel := diagramController model.
	connectedAssociations := ownerModel packagedElements
		select: [ :each | 
			(each isKindOf: OPUMLAssociation)
				and: [ each memberEnds anySatisfy: [ :any | any type = model ] ] ].
	connectedGeneralizations := ((ownerModel packagedElements
		select: [ :each | each isKindOf: OPUMLGeneralizationSet ])
		flatCollect: [ :each | each generalizations ])
		select: [ :each | each general = model or: [ each specific = model ] ].
	connectedAssociations , connectedGeneralizations
		do: [ :each | (diagramController controllerForModel: each) removeModel ].
	self remove.
	ownerModel packagedElements remove: self model
]

{ #category : #figures }
OPUmlClassController >> renderFigureIn: aView [
	diagramElement := self createDiagramElement.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self figure @ (OPRTUmlAdornments new adornments: self adornments).
	self refreshFigure.
	self figure @ RTDraggableSnapToGrid
]

{ #category : #rendering }
OPUmlClassController >> showInDiagram: aDiagramController [
	self renderFigureIn: aDiagramController view.
	(self allShowableElementsInModel: self model)
		do: [ :each | 
			| subCtrl |
			subCtrl := aDiagramController newControllerFor: each.
			aDiagramController addController: subCtrl.
			subCtrl showInDiagram: aDiagramController ]
]

{ #category : #accessing }
OPUmlClassController >> stereotypeNames [
	(self diagramController model oclIsKindOf: #Profile)
		ifTrue: [ ^ #(Metaclass) ].
	^ self model appliedStereotypes collect: #umlClassName
]
