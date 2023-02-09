Class {
	#name : #OPUmlClassControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlClassControllerTest >> controllerClass [
	^ OPUmlClassController
]

{ #category : #accessing }
OPUmlClassControllerTest >> modelClass [
	^ OPUMLClass
]

{ #category : #'instance creation' }
OPUmlClassControllerTest >> newEmptyClass [
	^ OPUMLClass new name: 'Something'
]

{ #category : #'tests - creation' }
OPUmlClassControllerTest >> testAddDiagramAsTargetForClass [
	diagramController addAsTargetFor: controller.
	self assert: diagramController model packagedElements asArray equals: {controller model}
]

{ #category : #'tests - creation' }
OPUmlClassControllerTest >> testCanDiagramBeTargetForClass [
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : #'tests - creation' }
OPUmlClassControllerTest >> testCreateDiagramElement [
	self assert: controller createDiagramElement class equals: OPUmlClassShape
]

{ #category : #'tests - creation' }
OPUmlClassControllerTest >> testCreateFromPalette [
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : #'tests - diagram' }
OPUmlClassControllerTest >> testPositionsOfContentOfAClass [
	| class operation operationController nameLabelRectangle operationLabelRectangle classRectangle elements |
	class := OPUMLClass new.
	class name: 'AClass'.
	operation := OPUMLOperation new.
	operation name: 'anOperation'.
	class ownedOperations add: operation.
	operationController := OPUmlOperationController new.
	operationController model: operation.
	diagramController model packagedElements add: class.
	diagramController rebuild.
	elements := diagramController view elements.
	nameLabelRectangle := (elements
		detect: [ :any | any model class = OPUmlNameLabel ])
		encompassingRectangle.
	operationLabelRectangle := (elements
		detect: [ :any | any model class = OPUmlLabel ])
		encompassingRectangle.
	classRectangle := (elements
		detect: [ :any | any model isKindOf: OPUmlClassShape ])
		encompassingRectangle.
	self
		assert: (classRectangle containsRect: nameLabelRectangle)
		description: 'Name of class is outside of class shape'.
	self
		assert: (classRectangle containsRect: operationLabelRectangle)
		description: 'Name of operation is outside of class shape'.
	self
		deny: (operationLabelRectangle intersects: nameLabelRectangle)
		description: 'Name of operation is overlapping name of class'.
	^ self
		assert: nameLabelRectangle bottom <= operationLabelRectangle top
		description: 'Name of operation is not below name of class'
]

{ #category : #'tests - removing' }
OPUmlClassControllerTest >> testRemoveEmpty [
	| class |
	class := OPUMLClass new.
	controller model: class.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeController.
	self assert: diagramController view elements asArray equals: #().
	self assert: diagramController controllers asArray equals: #()
]

{ #category : #'tests - removing' }
OPUmlClassControllerTest >> testRemoveFromModel [
	| class |
	class := OPUMLClass new.
	diagramController model packagedElements add: class.
	diagramController showWithoutDependentInDiagramModel: class.
	controller := diagramController controllerForModel: class.
	controller removeModel.
	self
		assert: diagramController model packagedElements asArray
		equals: #()
]

{ #category : #'tests - removing' }
OPUmlClassControllerTest >> testRemoveWithAttribute [

	| class |
	class := OPUMLClass new.
	class ownedAttributes add: OPUMLProperty new.
	controller model: class.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeController.
	self assert: diagramController view elements asArray equals: #(  ).
	self assert: diagramController controllers asArray equals: #(  )
]

{ #category : #'tests - removing' }
OPUmlClassControllerTest >> testRemovesDependent [
	| class secondClass association ownedClass owningClass |
	class := OPUMLClass new.
	secondClass := OPUMLClass new.
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
		memberEnds:
			{ownedClass.
			owningClass}.
	diagramController model packagedElements add: association.
	diagramController showWithoutDependentInDiagramModel: class.
	diagramController showWithoutDependentInDiagramModel: secondClass.
	diagramController showWithoutDependentInDiagramModel: association.
	controller := diagramController controllerForModel: class.
	controller removeFull.
	self
		assertCollection: diagramController model packagedElements asArray
		hasSameElements: {secondClass}
]

{ #category : #'tests - diagram' }
OPUmlClassControllerTest >> testShowClassInDiagram [
	| class |
	class := OPUMLClass new.
	diagramController showWithoutDependentInDiagramModel: class.
	self
		assert:
			(diagramController view elements
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = class ] ])
]

{ #category : #'tests - diagram' }
OPUmlClassControllerTest >> testShowClassWithAttributeInDiagram [
	| class prop |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	self
		assert:
			(diagramController view elements
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = prop ] ])
]

{ #category : #tests }
OPUmlClassControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: OPUMLClass new)
]
