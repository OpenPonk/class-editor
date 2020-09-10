Class {
	#name : #OPUmlEnumLiteralControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlEnumLiteralControllerTest >> controllerClass [
	^ OPUmlEnumerationLiteralController
]

{ #category : #accessing }
OPUmlEnumLiteralControllerTest >> modelClass [
	^ OPUMLEnumerationLiteral
]

{ #category : #'tests - creation' }
OPUmlEnumLiteralControllerTest >> testCanEnumerationBeTarget [
	| classController |
	classController := OPUmlEnumerationController new.
	self assert: (classController canBeTargetFor: controller)
]

{ #category : #'tests - creation' }
OPUmlEnumLiteralControllerTest >> testCreateDiagramElement [
	self assert: controller createDiagramElement class equals: OPUmlLabel
]

{ #category : #'tests - creation' }
OPUmlEnumLiteralControllerTest >> testEnumerationBeTarget [
	| classController |
	classController := diagramController
		newControllerFor: OPUMLEnumeration new.
	classController showWithoutDependentInDiagram: diagramController.
	classController addAsTargetFor: controller.
	self
		assert: classController model ownedLiterals asArray
		equals: {controller model}
]

{ #category : #'tests - accessing' }
OPUmlEnumLiteralControllerTest >> testModelClass [
	self assert: controller modelClass equals: self modelClass
]

{ #category : #'tests - removing' }
OPUmlEnumLiteralControllerTest >> testRemoveFromView [
	| class compartment prop |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	controller := diagramController controllerForModel: prop.
	compartment := controller diagramElement owningElement.
	controller remove.
	self assert: compartment ownedElements asArray equals: #()
]

{ #category : #'tests - testing' }
OPUmlEnumLiteralControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: OPUMLEnumerationLiteral new)
]
