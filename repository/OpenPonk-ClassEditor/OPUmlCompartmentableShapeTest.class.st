Class {
	#name : #OPUmlCompartmentableShapeTest,
	#superclass : #OPDiagramElementTestCase,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #accessing }
OPUmlCompartmentableShapeTest >> elementClass [
	^ OPUmlCompartmentableShape
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testEmptyRoassalShape [

	| roassalShape |
	element renderIn: RSCanvas new.
	roassalShape := element roassalShape.
	self assert: roassalShape class equals: RSBox
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures [

	element renderIn: RSCanvas new.

	self assert: element canvas nodes isNotEmpty
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures1 [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: element.

	self assert: element ownedElements asArray equals: { lbl }
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures2 [

	| lbl comp1 |
	(lbl := OPUmlLabel new) owningElement: element.
	(comp1 := OPUmlCompartment new) owningElement: element.

	self
		assertCollection: element ownedElements asArray
		hasSameElements: { 
				lbl.
				comp1 }
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures3 [

	| lbl comp compLbl |
	(lbl := OPUmlLabel new) owningElement: element.
	(comp := OPUmlCompartment new) owningElement: element.
	(compLbl := OPUmlLabel new) owningElement: comp.

	self
		assertCollection: element ownedElements asArray
		hasSameElements: (Array with: lbl with: comp)
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveExtentChanged [

	| compartment compLbl canvas fullExtent labelContainer |
	element modelElement: OPTestEntityModel new.
	labelContainer := OPUmlCompartmentableLabel in: element.
	OPUmlNameLabel in: labelContainer.
	compartment := OPUmlCompartment in: element.
	5 timesRepeat: [ 
		compLbl := (OPUmlLabel in: compartment)
			           text: 'testx';
			           yourself ].
	canvas := RSCanvas new.
	element renderIn: canvas.
	fullExtent := element extent.
	compLbl remove.
	element modelChanged.
	self assert: element extent y < fullExtent y
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveFromOwnership [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: element.
	self
		assertCollection: element ownedElements asArray
		hasSameElements: { lbl }.
	lbl remove.
	self assert: element ownedElements isEmpty
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveFromViewEmpty [

	| canvas |
	canvas := RSCanvas new.
	element renderIn: canvas.
	element remove.
	self assert: canvas nodes asArray equals: #(  )
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveOwnedElement [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: element.
	self assertCollection: element ownedElements hasSameElements: { lbl }.
	lbl owningElement: nil.
	self assert: element ownedElements isEmpty
]
