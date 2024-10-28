Class {
	#name : 'OPUmlEnumerationControllerTest',
	#superclass : 'OPUmlClassifierControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlEnumerationControllerTest >> controllerClass [
	^ OPUmlEnumerationController
]

{ #category : 'construction' }
OPUmlEnumerationControllerTest >> diagramElementClass [

	^ OPUmlEnumerationShape
]

{ #category : 'accessing' }
OPUmlEnumerationControllerTest >> modelClass [
	^ OPUMLEnumeration
]

{ #category : 'tests - removing' }
OPUmlEnumerationControllerTest >> testRemoveWithLiteral [

	model ownedLiterals add: OPUMLEnumerationLiteral new.
	controller model: model.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeControllerAndDiagramElement.
	self assert: diagramController canvas nodes asArray equals: #(  ).
	self assert: diagramController controllers asArray equals: #(  )
]

{ #category : 'tests - diagram' }
OPUmlEnumerationControllerTest >> testShowWithLiteralsInDiagram [

	| literal |
	literal := OPUMLEnumerationLiteral new name: 'enumLiteral'.
	model ownedLiterals add: literal.
	diagramController showInDiagramModel: model.
	self assert: (diagramController canvas nodes anySatisfy: [ :each | 
			 each model isNotNil and: [ each model modelElement = literal ] ])
]
