"
I am an abstract base test class verifying common structural behaviors, such as attaching edges and embedding owned elements, for UML node shapes.
"
Class {
	#name : 'OPAbstractUmlShapeTest',
	#superclass : 'OPAbstractNodeTest',
	#category : 'OpenPonk-ClassEditor-Tests-DiagramElements',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'tests' }
OPAbstractUmlShapeTest >> testAddEdge [

	| source target edge |
	source := self newShapeInstance.
	target := self newShapeInstance.
	edge := OPUmlEdge new.
	edge source: source.
	edge target: target.
	self assertCollection: source sourceEdges hasSameElements: { edge }.
	self assertCollection: target targetEdges hasSameElements: { edge }.
	self assertEmpty: source targetEdges.
	self assertEmpty: target sourceEdges.
	self assert: edge source equals: source.
	self assert: edge target equals: target
]

{ #category : 'tests' }
OPAbstractUmlShapeTest >> testAddOwnedElement [

	| parent child |
	parent := self newShapeInstance.
	child := self newShapeInstance.
	child owningElement: parent.
	self assert: parent owningElement identicalTo: OPNoShape instance.
	self assert: child owningElement identicalTo: parent.
	self assertCollection: parent ownedElements hasSameElements: { child }.
	self assertEmpty: child ownedElements
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

{ #category : 'running' }
OPAbstractUmlShapeTest >> testEmpty [

	super testEmpty.
	self assert: shape owningElement identicalTo: OPNoShape instance.
	self assertEmpty: shape ownedElements.
	self assertEmpty: shape sourceEdges.
	self assertEmpty: shape targetEdges
]
