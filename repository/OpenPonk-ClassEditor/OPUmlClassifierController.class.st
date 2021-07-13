Class {
	#name : #OPUmlClassifierController,
	#superclass : #OPUmlElementController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #adding }
OPUmlClassifierController >> addAsTargetFor: aController [
	aController
		createModelIn: self model
		andShowInDiagram: self diagramController
]

{ #category : #figures }
OPUmlClassifierController >> adornments [
	^ self subclassResponsibility
]

{ #category : #'events - registering' }
OPUmlClassifierController >> attachTo: aDiagramController [
	| newModel |
	newModel := self createModel.
	OPRenameElementCommand executeOn: newModel.
	aDiagramController model packagedElements add: newModel.
	aDiagramController showWithoutDependentInDiagramModel: newModel
]

{ #category : #adding }
OPUmlClassifierController >> canBeSourceFor: aController [
	^ aController isKindOf: OPUmlAssociationController
]

{ #category : #construction }
OPUmlClassifierController >> createModelIn: aParentModel [
	self
		model:
			(self modelClass new
				name: self modelClassName;
				yourself).
	aParentModel packagedElements add: model.
	^ model
]

{ #category : #forms }
OPUmlClassifierController >> descriptionName [
	<magritteDescription>
	| accessor |
	accessor := MAPluggableAccessor
		read: [ :me | me model name ]
		write: [ :me :newValue | 
			me model name: newValue.
			self refreshFigure ].
	^ MAMemoDescription new
		accessor: accessor;
		label: 'Name';
		priority: 1;
		yourself
]

{ #category : #testing }
OPUmlClassifierController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlClassifierController >> modelClassName [
	^ self subclassResponsibility
]

{ #category : #figures }
OPUmlClassifierController >> refreshFigure [
	self diagramElement changed.
	^ self figure
]

{ #category : #removing }
OPUmlClassifierController >> removeModel [
	diagramController model packagedElements remove: self model
]

{ #category : #figures }
OPUmlClassifierController >> renderFigureIn: aView [
	self diagramController addingFigureFor: self.
	diagramElement := self createDiagramElement.
	diagramElement renderIn: aView.
	diagramController addedFigureFor: self.
	self figure @ (OPRTAdornments new adornments: self adornments).
	self refreshFigure.
	self figure @ OPRTDraggableSnapToGrid.
	^ self figure
]
