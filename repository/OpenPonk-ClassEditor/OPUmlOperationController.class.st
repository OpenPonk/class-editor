"
I am a controller for Operation.
"
Class {
	#name : #OPUmlOperationController,
	#superclass : #OPUmlClassItemController,
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

{ #category : #figures }
OPUmlOperationController >> diagramElementClass [

	^ OPUmlOperationLabel
]

{ #category : #'as yet unclassified' }
OPUmlOperationController >> diagramElementOwner [

	^ (diagramController showWithoutDependentInDiagramModel: model owningClass)
		  diagramElement
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
