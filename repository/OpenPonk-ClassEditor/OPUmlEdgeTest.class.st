Class {
	#name : 'OPUmlEdgeTest',
	#superclass : 'OPAbstractEdgeTest',
	#category : 'OpenPonk-ClassEditor-Tests - Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Shapes'
}

{ #category : 'running' }
OPUmlEdgeTest >> setUp [
	| source target |
	super setUp.
	source := OPUmlLabel new.
	source text: 'src'.
	target := OPUmlLabel new.
	target text: 'tgt'.
	shape source: source.
	shape target: target
]

{ #category : 'hooks' }
OPUmlEdgeTest >> shapeClass [
	^ OPUmlEdge
]

{ #category : 'tests' }
OPUmlEdgeTest >> testRemove [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: shape.
	self assert: shape ownedElements asArray equals: { lbl }.
	lbl owningElement: OPNoShape new.
	self assert: shape ownedElements isEmpty
]

{ #category : 'tests' }
OPUmlEdgeTest >> testRemoveDetachFromEnds [

	| source target |
	source := OPUmlLabel new.
	target := OPUmlLabel new.
	shape source: source.
	shape target: target.
	shape remove.
	self assert: source sourceEdges asArray equals: #(  ).
	self assert: target targetEdges asArray equals: #(  )
]

{ #category : 'tests' }
OPUmlEdgeTest >> testRemoveFromView [

	| lbl |
	(lbl := OPUmlLabel new)
		text: 'x';
		owningElement: shape.
	shape source renderIn: canvas.
	shape target renderIn: canvas.
	shape renderIn: canvas.
	lbl renderIn: canvas.
	self assert: canvas nodes size equals: 3.
	shape remove.
	self assert: canvas shapes size equals: 2
]
