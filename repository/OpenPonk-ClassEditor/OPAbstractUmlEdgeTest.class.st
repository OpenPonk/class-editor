Class {
	#name : 'OPAbstractUmlEdgeTest',
	#superclass : 'OPAbstractEdgeTest',
	#category : 'OpenPonk-ClassEditor-Tests - DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - DiagramElements'
}

{ #category : 'running' }
OPAbstractUmlEdgeTest >> setUp [
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
OPAbstractUmlEdgeTest >> shapeClass [
	^ OPUmlEdge
]

{ #category : 'tests' }
OPAbstractUmlEdgeTest >> testRemove [

	| lbl |
	(lbl := OPUmlLabel new) owningElement: shape.
	self assert: shape ownedElements asArray equals: { lbl }.
	lbl owningElement: OPNoShape new.
	self assert: shape ownedElements isEmpty
]

{ #category : 'tests' }
OPAbstractUmlEdgeTest >> testRemoveDetachFromEnds [

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
OPAbstractUmlEdgeTest >> testRemoveFromView [

	| lbl |
	shape modelElement: model.
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
