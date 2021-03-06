Class {
	#name : #OPUmlEnumerationControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlEnumerationControllerTest >> controllerClass [
	^ OPUmlEnumerationController
]

{ #category : #accessing }
OPUmlEnumerationControllerTest >> modelClass [
	^ OPUMLEnumeration
]

{ #category : #'tests - creation' }
OPUmlEnumerationControllerTest >> testAddDiagramAsTargetForClass [
	diagramController addAsTargetFor: controller.
	self assert: diagramController model packagedElements asArray equals: {controller model}
]

{ #category : #'tests - creation' }
OPUmlEnumerationControllerTest >> testCanDiagramBeTargetForClass [
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : #'tests - creation' }
OPUmlEnumerationControllerTest >> testCreateDiagramElement [
	self assert: controller createDiagramElement class equals: OPUmlClassShape
]

{ #category : #'tests - accessing' }
OPUmlEnumerationControllerTest >> testModelClass [
	self assert: controller modelClass equals: self modelClass
]

{ #category : #'tests - removing' }
OPUmlEnumerationControllerTest >> testRemoveEmpty [
	controller model: model.
	controller showWithoutDependentInDiagram: diagramController.
	controller remove.
	self assert: diagramController view elements asArray equals: #().
	self assert: diagramController controllers asArray equals: #()
]

{ #category : #'tests - removing' }
OPUmlEnumerationControllerTest >> testRemoveFromModel [
	diagramController model packagedElements add: model.
	diagramController showWithoutDependentInDiagramModel: model.
	controller := diagramController controllerForModel: model.
	controller removeModel.
	self
		assert: diagramController model packagedElements asArray
		equals: #()
]

{ #category : #'tests - removing' }
OPUmlEnumerationControllerTest >> testRemoveWithLiteral [
	model ownedLiterals add: OPUMLEnumerationLiteral new.
	controller model: model.
	controller showWithoutDependentInDiagram: diagramController.
	controller remove.
	self assert: diagramController view elements asArray equals: #().
	self assert: diagramController controllers asArray equals: #()
]

{ #category : #'tests - diagram' }
OPUmlEnumerationControllerTest >> testShowInDiagram [
	diagramController showWithoutDependentInDiagramModel: model.
	self
		assert:
			(diagramController view elements
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = model ] ])
]

{ #category : #'tests - diagram' }
OPUmlEnumerationControllerTest >> testShowWithLiteralsInDiagram [
	| literal |
	literal := OPUMLEnumerationLiteral new name: 'enumLiteral'.
	model ownedLiterals add: literal.
	diagramController showInDiagramModel: model.
	self
		assert:
			(diagramController view elements
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = literal ] ])
]

{ #category : #'tests - testing' }
OPUmlEnumerationControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: model)
]
