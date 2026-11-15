"
I am a unit test class verifying the rendering and containment behavior of OPUmlClassShape, inheriting compartment testing from OPAbstractUmlCompartmentableShapeTest.
"
Class {
	#name : 'OPUmlClassShapeTest',
	#superclass : 'OPAbstractUmlCompartmentableShapeTest',
	#category : 'OpenPonk-ClassEditor-Tests-DiagramElements',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'instance creation' }
OPUmlClassShapeTest >> modelClass [

	^ OPUMLClass
]

{ #category : 'hooks' }
OPUmlClassShapeTest >> shapeClass [

	^ OPUmlClassShape
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testName [

	| labels label |
	model name: 'ClassName'.
	model isAbstract: false.
	shape modelElement: model.
	shape renderIn: canvas.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'ClassName'.
	self assert: label emphasis equals: TextEmphasis normal.

	model isAbstract: true.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'ClassName'.
	self assert: label emphasis equals: TextEmphasis italic.

	model name: 'Name2'.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'Name2'.
	self assert: label emphasis equals: TextEmphasis italic.

	model isAbstract: false.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'Name2'.
	self assert: label emphasis equals: TextEmphasis normal
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testStereotypeLabelNotDuplicatedOnReRender [

	| modelClass stereo initialStereoLabel stereoLabels |
	modelClass := OPUMLClass new name: 'Person'.
	stereo := OPUMLStereotype new.
	modelClass appliedStereotypes add: stereo.

	shape := OPUmlClassShape new.
	shape modelElement: modelClass.

	"1. Prvotní vykreslení"
	shape renderIn: canvas.
	initialStereoLabel := shape stereotypeLabel.
	self assert: initialStereoLabel class equals: OPUmlCompartmentableLabel.
	self assertCollection: shape ownedElements includesAll: { initialStereoLabel }.

	stereoLabels := shape ownedElements select: [ :each |
			                (each isKindOf: OPUmlCompartmentableLabel) and: [
				                each ownedElements anySatisfy: [ :child | child isKindOf: OPUmlAppliedStereotypesLabel ] ] ].
	self assert: stereoLabels size equals: 1.

	"2. Simulace zavření editoru diagramu"
	shape removeRender.

	"3. Simulace opětovného otevření editoru diagramu"
	canvas := RSCanvas new.
	shape renderIn: canvas.

	self assert: shape stereotypeLabel identicalTo: initialStereoLabel.

	stereoLabels := shape ownedElements select: [ :each |
			                (each isKindOf: OPUmlCompartmentableLabel) and: [
				                each ownedElements anySatisfy: [ :child | child isKindOf: OPUmlAppliedStereotypesLabel ] ] ].
	self assert: stereoLabels size equals: 1.
	self assert: stereoLabels anyOne identicalTo: initialStereoLabel
]
