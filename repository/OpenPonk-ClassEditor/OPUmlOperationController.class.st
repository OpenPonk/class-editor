"
I am a controller for Operation.
"
Class {
	#name : #OPUmlOperationController,
	#superclass : #OPUmlElementController,
	#category : 'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlOperationController >> createDiagramElement [
	^ OPUmlLabel new
		modelElement: self model;
		text: [ :aModel | self notationTextFor: aModel ];
		emphasis: [ :aModel :aStyle | 
			aStyle fontUnderline: aModel isStatic.
			aStyle fontItalic: aModel isAbstract ];
		localStyle: OPUmlStyle new;
		yourself
]

{ #category : #construction }
OPUmlOperationController >> createModelIn: aClassifierController andShowInDiagram: aDiagramController [
	| newModel |
	newModel := self modelClass new.
	newModel name: 'operation'.
	self model: newModel.
	aClassifierController model ownedOperations add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController
]

{ #category : #forms }
OPUmlOperationController >> descriptionIsAbstract [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isAbstract);
		label: 'Is Abstract';
		priority: 5;
		yourself
]

{ #category : #forms }
OPUmlOperationController >> descriptionIsStatic [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isStatic);
		label: 'Is Static';
		priority: 10;
		yourself
]

{ #category : #accessing }
OPUmlOperationController >> modelClass [
	^ OPUMLOperation
]

{ #category : #figures }
OPUmlOperationController >> notationTextFor: anOperation [
	^ anOperation notationString
]

{ #category : #figures }
OPUmlOperationController >> refreshFigure [
	self diagramElement changed.
	self diagramElement owningElement owningElement changed
]

{ #category : #removing }
OPUmlOperationController >> removeModel [
	self remove.
	"could be any of those, so just nil all of them"
	model owningClass: nil.
	model datatype: nil.
	model interface: nil
]

{ #category : #figures }
OPUmlOperationController >> renderFigureIn: aView [
	diagramElement := self createDiagramElement.
	diagramElement
		owningElement: (diagramController diagramElementForModel: model owningClass) operations.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure
]

{ #category : #figures }
OPUmlOperationController >> showInDiagram: aDiagramController [
	self renderFigureIn: aDiagramController view
]
