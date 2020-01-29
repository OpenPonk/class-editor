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
	aController
		createModelIn: self model
		andShowInDiagram: self diagramController
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
OPUmlClassController >> allShowableElements [
	| queue |
	queue := OrderedCollection new.
	queue addAll: self model ownedAttributes.
	queue addAll: self model ownedOperations.
	^ queue asArray
		select: [ :each | diagramController hasSupportForModel: each ]
]

{ #category : #'events - registering' }
OPUmlClassController >> attachTo: aDiagramController [
	| newModel |
	newModel := self createModel.
	OPRenameElementCommand executeOn: newModel.
	aDiagramController model packagedElements add: newModel.
	aDiagramController showInDiagramModel: newModel
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

{ #category : #construction }
OPUmlClassController >> createModelIn: aParentModel [
	self
		model:
			(self modelClass new
				name: self modelClassName;
				yourself).
	aParentModel packagedElements add: model.
	^ model
]

{ #category : #accessing }
OPUmlClassController >> dependentElements [
	^ self elementsToShowInside , self model generalizations
		,
			((diagramController model packagedElements
				select:
					[ :eachPackageElement | eachPackageElement oclIsKindOf: #GeneralizationSet ])
				flatCollectAsSet: [ :eachSet | 
					eachSet generalizations
						select: [ :eachGeneralization | 
							eachGeneralization general = self model
								or: [ eachGeneralization specific = self model ] ] ])
		,
			((diagramController model packagedElements
				select: [ :eachPackageElement | eachPackageElement oclIsKindOf: #Class ])
				flatCollectAsSet: [ :eachClass | 
					eachClass generalizations
						select: [ :eachGeneralization | 
							eachGeneralization general = self model
								or: [ eachGeneralization specific = self model ] ] ])
		,
			(diagramController model packagedElements
				select: [ :eachAssoc | 
					(eachAssoc oclIsKindOf: #Association)
						and: [ eachAssoc memberEnds
								anySatisfy: [ :any | any type = self model or: [ any owningClass = self model ] ] ] ])
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
OPUmlClassController >> elementsToShowInside [
	^ model ownedOperations asSet , model ownedAttributes
]

{ #category : #testing }
OPUmlClassController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlClassController >> modelClass [
	^ OPUMLClass
]

{ #category : #accessing }
OPUmlClassController >> modelClassName [
	^ #Class
]

{ #category : #figures }
OPUmlClassController >> refreshFigure [
	self diagramElement changed
]

{ #category : #removing }
OPUmlClassController >> removeModel [
	diagramController model packagedElements remove: self model
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

{ #category : #accessing }
OPUmlClassController >> stereotypeNames [
	(self diagramController model oclIsKindOf: #Profile)
		ifTrue: [ ^ #(Metaclass) ].
	^ self model appliedStereotypes collect: #umlClassName
]
