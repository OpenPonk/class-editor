"
I am the abstract base label shape for UML elements. I establish priority levels for label placement within UML compartments or edge adornments.
"
Class {
	#name : 'OPUmlLabel',
	#superclass : 'OPLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPUmlLabel class >> priority [
	^ 3
]
