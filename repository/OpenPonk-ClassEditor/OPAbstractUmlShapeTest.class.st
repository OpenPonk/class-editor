Class {
	#name : 'OPAbstractUmlShapeTest',
	#superclass : 'OPAbstractShapeTest',
	#category : 'OpenPonk-ClassEditor-Tests - Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Shapes'
}

{ #category : 'tests' }
OPAbstractUmlShapeTest >> testAddEdge [
	| source target edge |
	source := self newShapeInstance.
	target := self newShapeInstance.
	edge := OPUmlEdge new.
	edge source: source.
	edge target: target.
	self assertCollection: source sourceEdges hasSameElements: {edge}.
	self assertCollection: target targetEdges hasSameElements: {edge}.
	self assert: source targetEdges isEmpty.
	self assert: target sourceEdges isEmpty.
	self assert: edge source equals: source.
	self assert: edge target equals: target
]

{ #category : 'tests' }
OPAbstractUmlShapeTest >> testAddOwnedElement [
	| parent child |
	parent := self newShapeInstance.
	child := self newShapeInstance.
	child owningElement: parent.
	self assert: parent owningElement doesNotExist.
	self assert: child owningElement equals: parent.
	self assertCollection: parent ownedElements hasSameElements: {child}.
	self assert: child ownedElements size equals: 0
]

{ #category : 'tests' }
OPAbstractUmlShapeTest >> testAddSelfEdge [
	| edge |
	edge := OPUmlEdge new.
	edge source: shape.
	edge target: shape.
	self assert: shape sourceEdges asArray equals: {edge}.
	self assert: shape targetEdges asArray equals: {edge}.
	self assert: edge source equals: shape.
	self assert: edge target equals: shape
]

{ #category : 'tests' }
OPAbstractUmlShapeTest >> testEmpty [
	self assert: shape modelElement isNil.
	self assert: shape owningElement doesNotExist.
	self assert: shape ownedElements isEmpty.
	self assert: shape sourceEdges isEmpty.
	self assert: shape targetEdges isEmpty
]
