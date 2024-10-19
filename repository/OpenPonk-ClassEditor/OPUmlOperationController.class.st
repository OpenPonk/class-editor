"
I am a controller for Operation.
"
Class {
	#name : 'OPUmlOperationController',
	#superclass : 'OPUmlClassItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'figures' }
OPUmlOperationController >> addDiagramElementToOwner [

	self ownerDiagramElement addOperation: diagramElement
]

{ #category : 'construction' }
OPUmlOperationController >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  name: 'operation';
		  yourself
]

{ #category : 'forms' }
OPUmlOperationController >> descriptionIsAbstract [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isAbstract);
		label: 'Is Abstract';
		priority: 5;
		yourself
]

{ #category : 'figures' }
OPUmlOperationController >> diagramElementClass [

	^ OPUmlOperationLabel
]

{ #category : 'accessing' }
OPUmlOperationController >> modelClass [
	^ OPUMLOperation
]

{ #category : 'diagram elements' }
OPUmlOperationController >> owner [

	^ diagramController controllerForModel: model owningClass
]

{ #category : 'hooks' }
OPUmlOperationController >> placeholderName [

	^ 'operation'
]

{ #category : 'construction' }
OPUmlOperationController >> registerModelInContainer: aParentModel [

	aParentModel ownedOperations add: model
]

{ #category : 'removing' }
OPUmlOperationController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	self ownerDiagramElement ifNotNil: [ :owner |
		owner removeOperation: self diagramElement ].
	self diagramElement: OPNoShape new
]
