Class {
	#name : 'OPUmlClassShapeTest',
	#superclass : 'OPUmlCompartmentableShapeTest',
	#category : 'OpenPonk-ClassEditor-Tests - Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Shapes'
}

{ #category : 'hooks' }
OPUmlClassShapeTest >> shapeClass [
	^ OPUmlClassShape
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testName [

	| model labels label |
	model := OPUMLClass new.
	model name: 'ClassName'.
	model isAbstract: false.
	shape modelElement: model.
	shape renderIn: canvas.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.
	
	self assert: label text equals: 'ClassName'.
	self assert: label isNormal.

	model isAbstract: true.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'ClassName'.
	self assert: label isItalic.

	model name: 'Name2'.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'Name2'.
	self assert: label isItalic.

	model isAbstract: false.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'Name2'.
	self deny: label isItalic
]
