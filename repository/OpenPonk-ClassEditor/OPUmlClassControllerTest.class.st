Class {
	#name : 'OPUmlClassControllerTest',
	#superclass : 'OPUmlClassifierControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'accessing' }
OPUmlClassControllerTest >> controllerClass [
	^ OPUmlClassController
]

{ #category : 'construction' }
OPUmlClassControllerTest >> diagramElementClass [

	^ OPUmlClassShape
]

{ #category : 'accessing' }
OPUmlClassControllerTest >> modelClass [
	^ OPUMLClass
]

{ #category : 'tests - diagram' }
OPUmlClassControllerTest >> testPositionsOfContentOfAClass [

	| operation operationController nameLabelRectangle operationLabelRectangle classRectangle elements |
	operation := OPUMLOperation new.
	operation name: 'anOperation'.
	model ownedOperations add: operation.
	operationController := OPUmlOperationController new.
	operationController model: operation.
	diagramController model packagedElements add: model.
	controller model: model.
	controller showInDiagram: diagramController.
	operationController showInDiagram: diagramController.
	elements := diagramController canvas nodes.
	nameLabelRectangle := (elements detect: [ :any | 
		                       (any model isKindOf: OPUmlClassifierNameLabel) 
			                       or: [ 
				                       any model ownedElements anySatisfy: [ 
					                       :anyInner | 
					                       anyInner isKindOf:
						                       OPUmlClassifierNameLabel ] ] ])
		                      encompassingRectangle.
	operationLabelRectangle := (elements detect: [ :any | 
		                            (any model isKindOf: OPUmlOperationLabel) 
			                            or: [ 
				                            any model ownedElements anySatisfy: [ 
					                            :anyInner | 
					                            anyInner isKindOf:
						                            OPUmlOperationLabel ] ] ])
		                           encompassingRectangle.
	classRectangle := (elements detect: [ :any | 
		                   any model isKindOf: OPUmlClassShape ])
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

{ #category : 'tests - removing' }
OPUmlClassControllerTest >> testRemoveWithAttribute [

	| class |
	class := OPUMLClass new.
	class ownedAttributes add: OPUMLProperty new.
	controller model: class.
	controller showWithoutDependentInDiagram: diagramController.
	controller removeController.
	self assert: diagramController canvas nodes asArray equals: #(  ).
	self assert: diagramController controllers asArray equals: #(  )
]

{ #category : 'tests - diagram' }
OPUmlClassControllerTest >> testShowClassWithAttributeInDiagram [

	| prop |
	prop := OPUMLProperty new.
	model ownedAttributes add: prop.
	diagramController showInDiagramModel: model.
	self assert: (diagramController canvas nodes anySatisfy: [ :each |
			 each model isNotNil and: [ each model modelElement = prop ] ])
]
