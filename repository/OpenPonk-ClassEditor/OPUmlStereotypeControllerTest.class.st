Class {
	#name : #OPUmlStereotypeControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlStereotypeControllerTest >> controllerClass [
	^ OPUmlStereotypeController
]

{ #category : #accessing }
OPUmlStereotypeControllerTest >> modelClass [
	^ OPUMLStereotype
]

{ #category : #'instance creation' }
OPUmlStereotypeControllerTest >> newEmptyClass [
	^ OPUMLStereotype new name: 'Something'
]

{ #category : #'instance creation' }
OPUmlStereotypeControllerTest >> newEmptyModel [
	^ OPUMLStereotype new name: 'Something'
]

{ #category : #'tests - creation' }
OPUmlStereotypeControllerTest >> testAddDiagramAsTargetForClass [
	diagramController addAsTargetFor: controller.
	self assert: diagramController model packagedElements asArray equals: {controller model}
]

{ #category : #'tests - creation' }
OPUmlStereotypeControllerTest >> testCanDiagramBeTargetForClass [
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : #'tests - creation' }
OPUmlStereotypeControllerTest >> testCreateDiagramElement [
	self assert: controller createDiagramElement class equals: OPUmlClassShape
]

{ #category : #'tests - creation' }
OPUmlStereotypeControllerTest >> testCreateFromPalette [
	self assert: (diagramController canBeTargetFor: controller)
]

{ #category : #'tests - removing' }
OPUmlStereotypeControllerTest >> testRemoveEmpty [
	| class |
	class := self newEmptyModel.
	controller model: class.
	diagramController addController: controller.
	controller showInDiagram: diagramController.
	controller remove.
	self assert: diagramController view elements asArray equals: #().
	self assert: diagramController controllers asArray equals: #()
]

{ #category : #'tests - removing' }
OPUmlStereotypeControllerTest >> testRemoveFromModel [
	| class |
	class := self newEmptyModel.
	diagramController model packagedElements add: class.
	diagramController showInDiagramModel: class.
	controller := diagramController controllerForModel: class.
	controller removeModel.
	self assert: diagramController view elements asArray equals: #().
	self assert: diagramController model packagedElements asArray equals: #().
	self assert: diagramController controllers asArray equals: #()
]

{ #category : #'tests - removing' }
OPUmlStereotypeControllerTest >> testRemoveWithAttribute [
	| class |
	class := self newEmptyModel.
	class ownedAttributes add: OPUMLProperty new.
	controller model: class.
	diagramController addController: controller.
	controller showInDiagram: diagramController.
	controller remove.
	self assert: diagramController view elements asArray equals: #().
	self assert: diagramController controllers asArray equals: #()
]

{ #category : #'tests - diagram' }
OPUmlStereotypeControllerTest >> testShowClassInDiagram [
	| class |
	class := self newEmptyModel.
	diagramController showInDiagramModel: class.
	self
		assert:
			(diagramController view elements
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = class ] ])
]

{ #category : #'tests - diagram' }
OPUmlStereotypeControllerTest >> testShowClassWithAttributeInDiagram [
	| class prop |
	class := self newEmptyModel.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	self
		assert:
			(diagramController view elements
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = prop ] ])
]

{ #category : #tests }
OPUmlStereotypeControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: self newEmptyModel)
]
