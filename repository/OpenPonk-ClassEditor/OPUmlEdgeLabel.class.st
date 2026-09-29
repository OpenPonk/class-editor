"
A specialized text label attached to UML connection edges, enforcing minimum distance constraints to prevent line overlapping.
"
Class {
	#name : 'OPUmlEdgeLabel',
	#superclass : 'OPEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlEdgeLabel >> defaultMinDistance [

	^ 5
]
