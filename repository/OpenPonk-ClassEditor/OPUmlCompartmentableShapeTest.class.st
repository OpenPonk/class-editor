Class {
	#name : #OPUmlCompartmentableShapeTest,
	#superclass : #OPAbstractUmlShapeTest,
	#category : #'OpenPonk-ClassEditor-Tests - Shapes'
}

{ #category : #hooks }
OPUmlCompartmentableShapeTest >> shapeClass [
	^ OPUmlCompartmentableShape
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testEmptyRoassalShape [

	| roassalShape |
	shape renderIn: RSCanvas new.
	roassalShape := shape roassalShape.
	self assert: roassalShape class equals: RSBox
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures [

	shape renderIn: RSCanvas new.

	self assert: shape canvas nodes isNotEmpty
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures1 [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: shape.

	self assert: shape ownedElements asArray equals: { lbl }
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures2 [

	| lbl comp1 |
	(lbl := OPUmlLabel new) owningElement: shape.
	(comp1 := OPUmlCompartment new) owningElement: shape.

	self
		assertCollection: shape ownedElements asArray
		hasSameElements: { 
				lbl.
				comp1 }
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures3 [

	| lbl comp compLbl |
	(lbl := OPUmlLabel new) owningElement: shape.
	(comp := OPUmlCompartment new) owningElement: shape.
	(compLbl := OPUmlLabel new) owningElement: comp.

	self
		assertCollection: shape ownedElements asArray
		hasSameElements: (Array with: lbl with: comp)
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveExtentChanged [

	| compartment compLbl canvas fullExtent labelContainer |
	shape modelElement: OPTestEntityModel new.
	labelContainer := OPUmlCompartmentableLabel in: shape.
	OPUmlNameLabel in: labelContainer.
	compartment := OPUmlCompartment in: shape.
	5 timesRepeat: [ 
		compLbl := (OPUmlLabel in: compartment)
			           text: 'testx';
			           yourself ].
	canvas := RSCanvas new.
	shape renderIn: canvas.
	fullExtent := shape extent.
	compLbl remove.
	shape modelChanged.
	self assert: shape extent y < fullExtent y
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveFromOwnership [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: shape.
	self
		assertCollection: shape ownedElements asArray
		hasSameElements: { lbl }.
	lbl remove.
	self assert: shape ownedElements isEmpty
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveFromViewEmpty [

	| canvas |
	canvas := RSCanvas new.
	shape renderIn: canvas.
	shape remove.
	self assert: canvas nodes asArray equals: #(  )
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveOwnedElement [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: shape.
	self assertCollection: shape ownedElements hasSameElements: { lbl }.
	lbl owningElement: nil.
	self assert: shape ownedElements isEmpty
]
