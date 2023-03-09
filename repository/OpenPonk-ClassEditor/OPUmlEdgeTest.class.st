Class {
	#name : #OPUmlEdgeTest,
	#superclass : #OPDiagramElementTestCase,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlEdgeTest >> elementClass [
	^ OPUmlEdge
]

{ #category : #running }
OPUmlEdgeTest >> setUp [
	| source target |
	super setUp.
	source := OPUmlLabel new.
	source text: 'src'.
	target := OPUmlLabel new.
	target text: 'tgt'.
	element source: source.
	element target: target
]

{ #category : #tests }
OPUmlEdgeTest >> testRemove [
	| lbl |
	(lbl := OPUmlLabel new) owningElement: element.
	self assert: element ownedElements asArray equals: {lbl}.
	lbl owningElement: nil.
	self assert: element ownedElements isEmpty
]

{ #category : #tests }
OPUmlEdgeTest >> testRemoveDetachFromEnds [
	| source target  |
	source := OPUmlLabel new.
	target := OPUmlLabel new.
	element source: source.
	element target: target.
	element remove.
	self assert: source sourceEdges asArray equals: #().
	self assert: target targetEdges asArray equals: #()
]

{ #category : #tests }
OPUmlEdgeTest >> testRemoveFromView [

	| lbl canvas |
	(lbl := OPUmlLabel new)
		text: 'x';
		owningElement: element.
	canvas := RSCanvas new.
	element source renderIn: canvas.
	element target renderIn: canvas.
	element renderIn: canvas.
	lbl renderIn: canvas.
	self assert: canvas nodes size equals: 3.
	element remove.
	self assert: canvas shapes size equals: 2
]
