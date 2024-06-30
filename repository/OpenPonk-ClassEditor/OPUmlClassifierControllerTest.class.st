Class {
	#name : 'OPUmlClassifierControllerTest',
	#superclass : 'OPUmlElementControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'testing' }
OPUmlClassifierControllerTest class >> isAbstract [
	^ self = OPUmlClassifierControllerTest
]

{ #category : 'tests - creation' }
OPUmlClassifierControllerTest >> testAddDiagramAsTargetForClass [
	diagramController addAsTargetFor: controller.
	self assert: diagramController model packagedElements asArray equals: {controller model}
]

{ #category : 'tests - creation' }
OPUmlClassifierControllerTest >> testCanDiagramBeTargetForClass [
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : 'tests - creation' }
OPUmlClassifierControllerTest >> testCreateFromPalette [
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : 'tests - removing' }
OPUmlClassifierControllerTest >> testRemoveEmpty [

	controller model: model.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeController.
	self assert: diagramController canvas nodes asArray equals: #(  ).
	self assert: diagramController controllers asArray equals: #(  )
]

{ #category : 'tests - removing' }
OPUmlClassifierControllerTest >> testRemovesDependent [

	| class secondClass association ownedClass owningClass |
	class := model.
	secondClass := self newModel.
	diagramController model packagedElements add: class.
	diagramController model packagedElements add: secondClass.
	association := OPUMLAssociation new.
	(ownedClass := OPUMLProperty new)
		owningClass: class;
		type: secondClass.
	(owningClass := OPUMLProperty new)
		owningAssociation: association;
		type: secondClass.
	association
		name: 'association';
		memberEnds: {
				ownedClass.
				owningClass }.
	diagramController model packagedElements add: association.
	diagramController showWithoutDependentInDiagramModel: class.
	diagramController showWithoutDependentInDiagramModel: secondClass.
	diagramController showWithoutDependentInDiagramModel: association.
	controller := diagramController controllerForModel: class.
	controller removeControllerAndModel.
	self
		assertCollection: diagramController model packagedElements asArray
		hasSameElements: { secondClass }
]
