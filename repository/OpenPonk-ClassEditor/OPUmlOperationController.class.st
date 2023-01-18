"
I am a controller for Operation.
"
Class {
	#name : #OPUmlOperationController,
	#superclass : #OPUmlElementController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlOperationController >> createDiagramElement [
	^ OPUmlLabel new
		modelElement: self model;
		text: [ :aModel | self notationTextFor: aModel ];
		emphasis: [ :aModel :aStyle | 
			aStyle fontUnderline: aModel isStatic.
			aStyle fontItalic: aModel isAbstract ];
		localStyle: OPDIOpenPonkStyle new;
		yourself
]

{ #category : #construction }
OPUmlOperationController >> createModelIn: aParentModel [
	self
		model:
			(self modelClass new
				name: 'operation';
				yourself).
	aParentModel ownedOperations add: model.
	^ model
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

{ #category : #testing }
OPUmlOperationController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlOperationController >> modelClass [
	^ OPUMLOperation
]

{ #category : #figures }
OPUmlOperationController >> notationTextFor: anOperation [

	^ anOperation notationString
		  replaceAll: Character lf with: Character space;
		  replaceAll: Character cr with: Character space;
		  yourself
]

{ #category : #figures }
OPUmlOperationController >> refreshFigure [
	self diagramElement changed.
	self diagramElement owningElement owningElement changed.
	^ self figure
]

{ #category : #removing }
OPUmlOperationController >> removeModel [
	"could be any of those, so just nil all of them"
	model owningClass: nil.
	model datatype: nil.
	model interface: nil
]

{ #category : #figures }
OPUmlOperationController >> renderFigureIn: aView [
	self diagramController addingFigureFor: self.
	diagramElement := self createDiagramElement.
	diagramElement
		owningElement: (diagramController diagramElementForModel: model owningClass) operations.
	diagramElement renderIn: aView.
	diagramController addedFigureFor: self.
	^ self refreshFigure
]
