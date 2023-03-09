Class {
	#name : #OPUmlCompartmentableShapeTest,
	#superclass : #OPDiagramElementTestCase,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
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

	self assert: element figures asArray equals: {lbl}
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures2 [
	| lbl comp1 |
	(lbl := OPUmlLabel new) owningElement: element.
	(comp1 := OPUmlCompartment new) owningElement: element.

	self assert: element figures asArray equals: {lbl}
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testFigures3 [
	| lbl comp compLbl |
	(lbl := OPUmlLabel new) owningElement: element.
	(comp := OPUmlCompartment new) owningElement: element.
	(compLbl := OPUmlLabel new) owningElement: comp.

	self assert: element figures asArray equals: (Array with: lbl with: compLbl)
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveExtentChanged [
	| compartment compLbl canvas fullExtent |
	OPUmlNameLabel new owningElement: element.
	compartment := OPUmlCompartment new.
	compartment owningElement: element.
	5 timesRepeat: [ (compLbl := OPUmlLabel new) owningElement: compartment ].
	canvas := RSCanvas new.
	element renderIn: canvas.
	fullExtent := element extent.
	compLbl remove.
	self assert: element extent y < fullExtent y
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveFromOwnership [
	| lbl |
	(lbl := OPUmlLabel new) owningElement: element.
	self assert: element figures asArray equals: {lbl}.
	lbl remove.
	self assert: element figures isEmpty
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
OPUmlCompartmentableShapeTest >> testRemoveFromViewRich [
	| canvas lbl comp compLbl |
	element := OPUmlClassifierShape new.
	lbl := OPUmlNameLabel new.
	lbl owningElement: element.
	comp := OPUmlCompartment new.
	comp owningElement: element.
	(compLbl := OPUmlLabel new) owningElement: comp.
	canvas := RSCanvas new.
	element renderIn: canvas.
	element remove.
	self assert: canvas elements asArray equals: #()
]

{ #category : #tests }
OPUmlCompartmentableShapeTest >> testRemoveOwnedElement [
	| lbl |
	(lbl := OPUmlLabel new) owningElement: element.
	self assert: element figures asArray equals: {lbl}.
	lbl owningElement: nil.
	self assert: element figures isEmpty
]
