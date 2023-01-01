"
I am a controller for a Class(ifier)
"
Class {
	#name : #OPUmlClassController,
	#superclass : #OPUmlClassifierController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlClassController >> adornments [

	^ { 
		  (OPUmlIcons attributeIcon -> [ 
		   | tool |
		   tool := OPCreationTool new
			           palette: self diagramController editor palette;
			           factory: [ OPUmlAttributeController new ].
		   self diagramController editor palette selectTool: tool.
		   tool whenCreated: [ :ctrl | 
			   OPRenameElementCommand executeOn: ctrl ].
		   tool selectedTargetControllers: { self } ]).
		  (OPUmlIcons directedAssociationIcon -> [ 
		   | tool |
		   tool := OPConnectionCreationTool new
			           palette: self diagramController editor palette;
			           factory: [ OPUmlAssociationController new ].
		   self diagramController editor palette selectTool: tool.
		   tool selectedSourceControllers: { self } ]).
		  (OPUmlIcons generalizationIcon -> [ 
		   | tool |
		   tool := OPConnectionCreationTool new
			           palette: self diagramController editor palette;
			           factory: [ OPUmlGeneralizationController new ].
		   self diagramController editor palette selectTool: tool.
		   tool selectedSourceControllers: { self } ]) }
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
		| (super canBeSourceFor: aController)
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
		comments: [ self model ownedComments ];
		modelElement: self model
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

{ #category : #accessing }
OPUmlClassController >> modelClass [
	^ OPUMLClass
]

{ #category : #accessing }
OPUmlClassController >> modelClassName [
	^ #Class
]

{ #category : #accessing }
OPUmlClassController >> stereotypeNames [
	(self diagramController model oclIsKindOf: #Profile)
		ifTrue: [ ^ #(Metaclass) ].
	^ self model appliedStereotypes collect: #umlClassName
]
