Class {
	#name : #OPUmlAssociationControllerTest,
	#superclass : #OPUmlRelationshipControllerTest,
	#instVars : [
		'element',
		'comment',
		'ownedComment',
		'owningElement'
	],
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlAssociationControllerTest >> controllerClass [
	^ OPUmlAssociationController
]

{ #category : #construction }
OPUmlAssociationControllerTest >> diagramElementClass [

	^ OPUmlAssociationShape
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
	model := OPUMLAssociation new.
	(ownedComment := OPUMLProperty new)
		name: 'ownedComment';
		owningClass: element;
		type: comment.
	(owningElement := OPUMLProperty new)
		name: 'owningElement';
		owningAssociation: model;
		type: element.
	model
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
OPUmlAssociationControllerTest >> testRemovalOfAssociationRemovesMemberEnds [
	diagramController model packagedElements
		addAll:
			{element.
			comment.
			model}.
	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: model.
	(diagramController controllerForModel: model) removeControllerAndModel.
	(diagramController controllerForModel: comment) removeControllerAndModel.
	(diagramController controllerForModel: element) removeControllerAndModel.
	self assert: diagramController controllers asArray equals: #()
]

{ #category : #'tests - diagram' }
OPUmlAssociationControllerTest >> testRemovalOfClassRemovesAssociation [

	| elementController |
	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: model.
	diagramController model packagedElements addAll: { 
			element.
			comment.
			model }.
	elementController := diagramController controllerForModel: element.
	self
		deny: (diagramController canvas nodes count: [ :e | 
				 (e respondsTo: #text) and: [ 
					 { 'owningElement'. 'ownedComment'. 'association'. '1' } 
						 includes: e text ] ])
		equals: 0.
	elementController removeControllerAndModel.
	self
		assert: (diagramController canvas nodes select: [ :e | 
				 (e respondsTo: #text) and: [ 
					 { 'owningElement'. 'ownedComment'. 'association'. '1' } 
						 includes: e text ] ]) asArray
		equals: #(  )
]

{ #category : #'tests - diagram' }
OPUmlAssociationControllerTest >> testRemoveFromDiagram [

	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: model.
	controller := diagramController controllerForModel: model.
	self assert: diagramController canvas edges asArray isNotEmpty.
	controller removeController.
	self assert: diagramController canvas edges asArray equals: #(  )
]

{ #category : #'tests - model' }
OPUmlAssociationControllerTest >> testRemoveFromModel [
	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: model.
	self
		deny: (diagramController model packagedElements includes: model).
	controller := diagramController controllerForModel: model.
	diagramController model packagedElements add: model.
	self
		assert: (diagramController model packagedElements includes: model).
	self assert: ownedComment association equals: model.
	self assert: ownedComment owningClass equals: element.
	controller removeModel.
	self assert: ownedComment association equals: nil.
	self assert: ownedComment owningClass equals: nil.
	self
		deny: (diagramController model packagedElements includes: model)
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testShowInDiagram [

	diagramController
		showWithoutDependentInDiagramModel: element;
		showWithoutDependentInDiagramModel: comment;
		showWithoutDependentInDiagramModel: model.
	self assert: (diagramController canvas edges anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = model ] ])
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testWriteNavigabilityAssocOwnedToClassOwned [
	| first second |
	first := model memberEnds first.
	second := model memberEnds second.
	controller writeNavigability: true to: second.
	self assert: second isNavigable.
	self assert: second owningClass equals: first type
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testWriteNavigabilityClassOwnedToAssocOwned [
	| first |
	first := model memberEnds first.
	controller writeNavigability: false to: first.
	self deny: first isNavigable.
	self assert: first owningClass equals: nil.
	self assert: first owningAssociation equals: model
]

{ #category : #tests }
OPUmlAssociationControllerTest >> testWriteNavigabilityPrecondition [
	| first second |
	first := model memberEnds first.
	second := model memberEnds second.
	self assert: first isNavigable.
	self deny: second isNavigable.
	self assert: first owningClass isNotNil.
	self assert: second owningClass isNil.
	self assert: model navigableOwnedEnds asArray equals: #()
]
