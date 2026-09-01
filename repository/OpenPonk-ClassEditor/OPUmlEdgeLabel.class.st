"
I am a specialized text label designed to be attached to UML relationship edges. I calculate default minimum distances to ensure labels (like role names and multiplicities) do not overlap with the edge line.
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
