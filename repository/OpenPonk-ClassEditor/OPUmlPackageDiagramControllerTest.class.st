Class {
	#name : #OPUmlPackageDiagramControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : #'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlPackageDiagramControllerTest >> controllerClass [
	^ OPUmlPackageDiagramController
]

{ #category : #accessing }
OPUmlPackageDiagramControllerTest >> modelClass [
	^ OPUMLPackage
]

{ #category : #tests }
OPUmlPackageDiagramControllerTest >> testShowClassInDiagram [
	| class |
	class := OPUMLClass new.
	diagramController showWithoutDependentInDiagramModel: class.
	self
		assert:
			(diagramController view elements
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = class ] ])
]

{ #category : #tests }
OPUmlPackageDiagramControllerTest >> testShowClassWithAttributeInDiagram [
	| class prop |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	prop name: 'prop'.
	class ownedAttributes add: prop.
	diagramController showInDiagramModel: class.
	self
		assert:
			(diagramController view elements
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = prop ] ])
]
