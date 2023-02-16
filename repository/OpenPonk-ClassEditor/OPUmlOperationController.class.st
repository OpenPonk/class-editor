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

	diagramElement := self diagramElementClass forModelElement:
		                  self model.

	self diagramElementOwner addOperation: diagramElement
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

{ #category : #figures }
OPUmlOperationController >> diagramElementClass [

	^ OPUmlOperationLabel
]

{ #category : #'as yet unclassified' }
OPUmlOperationController >> diagramElementOwner [

	^ (diagramController showWithoutDependentInDiagramModel: model owningClass)
		  diagramElement
]

{ #category : #testing }
OPUmlOperationController >> isHideable [
	^ true
]

{ #category : #accessing }
OPUmlOperationController >> modelClass [
	^ OPUMLOperation
]

{ #category : #removing }
OPUmlOperationController >> removeDiagramElement [

	self diagramElement ifNil: [ ^ self ].
	self diagramElementOwner removeOperation: self diagramElement.
	diagramElement := nil
]

{ #category : #removing }
OPUmlOperationController >> removeModel [
	"could be any of those, so just nil all of them"
	model owningClass: nil.
	model datatype: nil.
	model interface: nil
]
