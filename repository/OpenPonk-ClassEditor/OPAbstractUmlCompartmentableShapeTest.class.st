"
I am an abstract base test class verifying the behavior of UML shapes containing compartments, focusing on rendering figures, extent recalculations, and nested element ownership.
"
Class {
	#name : 'OPAbstractUmlCompartmentableShapeTest',
	#superclass : 'OPAbstractUmlShapeTest',
	#category : 'OpenPonk-ClassEditor-Tests - DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - DiagramElements'
}

{ #category : 'hooks' }
OPAbstractUmlCompartmentableShapeTest >> shapeClass [
	^ OPUmlCompartmentableShape
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testEmptyRoassalShape [

	| roassalShape |
	shape renderIn: RSCanvas new.
	roassalShape := shape roassalShape.
	self assert: roassalShape class equals: RSBox
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testFigures [

	shape renderIn: RSCanvas new.

	self assert: shape canvas nodes isNotEmpty
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testFigures1 [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: shape.

	self assert: shape ownedElements asArray equals: { lbl }
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testFigures2 [

	| lbl comp1 |
	(lbl := OPUmlLabel new) owningElement: shape.
	(comp1 := OPUmlCompartment new) owningElement: shape.

	self
		assertCollection: shape ownedElements asArray
		hasSameElements: { 
				lbl.
				comp1 }
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testFigures3 [

	| lbl comp compLbl |
	(lbl := OPUmlLabel new) owningElement: shape.
	(comp := OPUmlCompartment new) owningElement: shape.
	(compLbl := OPUmlLabel new) owningElement: comp.

	self
		assertCollection: shape ownedElements asArray
		hasSameElements: (Array with: lbl with: comp)
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testRemoveExtentChanged [

	| compartment compLbl fullExtent labelContainer |
	labelContainer := OPUmlCompartmentableLabel in: shape.
	OPUmlNameLabel in: labelContainer.
	compartment := OPUmlCompartment in: shape.
	5 timesRepeat: [ 
		compLbl := (OPUmlLabel in: compartment)
			           text: 'testx';
			           yourself ].
	shape renderIn: canvas.
	fullExtent := shape extent.
	compLbl remove.
	shape modelChanged.
	self assert: shape extent y < fullExtent y
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testRemoveFromOwnership [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: shape.
	self
		assertCollection: shape ownedElements asArray
		hasSameElements: { lbl }.
	lbl remove.
	self assert: shape ownedElements isEmpty
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testRemoveFromViewEmpty [

	| emptyCanvas |
	emptyCanvas := RSCanvas new.
	shape renderIn: emptyCanvas.
	shape remove.
	self assert: emptyCanvas nodes asArray equals: #(  )
]

{ #category : 'tests' }
OPAbstractUmlCompartmentableShapeTest >> testRemoveOwnedElement [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: shape.
	self assertCollection: shape ownedElements hasSameElements: { lbl }.
	lbl owningElement: OPNoShape new.
	self assert: shape ownedElements isEmpty
]
