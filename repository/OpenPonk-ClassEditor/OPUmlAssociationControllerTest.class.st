Class {
	#name : #OPUmlAssociationControllerTest,
	#superclass : #OPUmlRelationshipControllerTest,
	#instVars : [
		'element',
		'comment',
		'association',
		'ownedComment',
		'owningElement'
	],
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlAssociationControllerTest >> controllerClass [
	^ OPUmlAssociationController
]

{ #category : #accessing }
OPUmlAssociationControllerTest >> modelClass [
	^ OPUMLAssociation
]

{ #category : #running }
OPUmlAssociationControllerTest >> setUp [
	super setUp.
	self setUpAssociation
]

{ #category : #running }
OPUmlAssociationControllerTest >> setUpAssociation [
	element := OPUMLClass new name: 'Element'.
	comment := OPUMLClass new name: 'Comment'.
	association := OPUMLAssociation new.
	(ownedComment := OPUMLProperty new)
		name: 'ownedComment';
		owningClass: element;
		type: comment.
	(owningElement := OPUMLProperty new)
		name: 'owningElement';
		owningAssociation: association;
		type: element.
	association
		name: 'association';
		memberEnds:
			{ownedComment.
			owningElement}
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testClassBeTarget [
	| sourceController targetController |
	sourceController := diagramController
		newControllerFor: (OPUMLClass new name: 'A').
	targetController := diagramController
		newControllerFor: (OPUMLClass new name: 'B').
	sourceController showWithoutDependentInDiagram: diagramController.
	targetController showWithoutDependentInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	targetController addAsTargetFor: controller.
	self
		assert: (controller model memberEnds collect: #name) asArray
		equals: #(a b).
	self
		assert: controller model memberEnds first owningAssociation
		equals: controller model.
	self
		assert: controller model memberEnds first type
		equals: sourceController model.
	self
		assert: controller model memberEnds second owningAssociation
		equals: controller model.
	self
		assert: controller model memberEnds second type
		equals: targetController model
]

{ #category : #'tests - diagram' }
OPUmlAssociationControllerTest >> testCreateDiagramElement [
	controller model: association.
	self assert: controller createDiagramElement class equals: OPUmlAssociationShape
]

{ #category : #'tests - diagram' }
OPUmlAssociationControllerTest >> testRemovalOfAssociationRemovesMemberEnds [
	diagramController model packagedElements
		addAll:
			{element.
			comment.
			association}.
	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: association.
	(diagramController controllerForModel: association) removeFull.
	(diagramController controllerForModel: comment) removeFull.
	(diagramController controllerForModel: element) removeFull.
	self assert: diagramController controllers asArray equals: #()
]

{ #category : #'tests - diagram' }
OPUmlAssociationControllerTest >> testRemovalOfClassRemovesAssociation [
	| elementController |
	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: association.
	diagramController model packagedElements
		addAll:
			{element.
			comment.
			association}.
	elementController := diagramController controllerForModel: element.
	self
		deny:
			(diagramController view elements
				count: [ :e | 
					(e trachelShape respondsTo: #text)
						and: [ {'owningElement' . 'ownedComment' . 'association' . '1'}
								includes: e trachelShape text ] ])
		equals: 0.
	elementController removeFull.
	self
		assert:
			(diagramController view elements
				select: [ :e | 
					(e trachelShape respondsTo: #text)
						and: [ {'owningElement' . 'ownedComment' . 'association' . '1'}
								includes: e trachelShape text ] ]) asArray
		equals: #()
]

{ #category : #'tests - diagram' }
OPUmlAssociationControllerTest >> testRemoveFromDiagram [
	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: association.
	controller := diagramController controllerForModel: association.
	self assert: diagramController view edges asArray isNotEmpty.
	controller remove.
	self assert: diagramController view edges asArray equals: #()
]

{ #category : #'tests - model' }
OPUmlAssociationControllerTest >> testRemoveFromModel [
	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: association.
	self
		deny: (diagramController model packagedElements includes: association).
	controller := diagramController controllerForModel: association.
	diagramController model packagedElements add: association.
	self
		assert: (diagramController model packagedElements includes: association).
	self assert: ownedComment association equals: association.
	self assert: ownedComment owningClass equals: element.
	controller removeModel.
	self assert: ownedComment association equals: nil.
	self assert: ownedComment owningClass equals: nil.
	self
		deny: (diagramController model packagedElements includes: association)
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testShowInDiagram [
	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: association.
	self
		assert:
			(diagramController view edges
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = association ] ])
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: OPUMLAssociation new)
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testWriteNavigabilityAssocOwnedToClassOwned [
	| first second |
	first := association memberEnds first.
	second := association memberEnds second.
	controller writeNavigability: true to: second.
	self assert: second isNavigable.
	self assert: second owningClass equals: first type
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testWriteNavigabilityClassOwnedToAssocOwned [
	| first |
	first := association memberEnds first.
	controller writeNavigability: false to: first.
	self deny: first isNavigable.
	self assert: first owningClass equals: nil.
	self assert: first owningAssociation equals: association
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testWriteNavigabilityPrecondition [
	| first second |
	first := association memberEnds first.
	second := association memberEnds second.
	self assert: first isNavigable.
	self deny: second isNavigable.
	self assert: first owningClass isNotNil.
	self assert: second owningClass isNil.
	self assert: association navigableOwnedEnds asArray equals: #()
]
