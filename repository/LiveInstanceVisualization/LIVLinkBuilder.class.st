Class {
	#name : 'LIVLinkBuilder',
	#superclass : 'Object',
	#instVars : [
		'source',
		'target'
	],
	#category : 'LiveInstanceVisualization-Models',
	#package : 'LiveInstanceVisualization',
	#tag : 'Models'
}

{ #category : 'as yet unclassified' }
LIVLinkBuilder >> build [
	| edge |
	edge := OPUmlEdge new
		source: source;
		target: target;
		modelElement: source modelElement -> target modelElement;
		yourself.
	edge headDecorator: RTSimpleArrow.
	^ edge
]
