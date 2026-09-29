"
A specialized label displaying the primary name of a UML element with fallback handling for unnamed elements.
"
Class {
	#name : 'OPUmlNameLabel',
	#superclass : 'OPUmlLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPUmlNameLabel class >> priority [
	^ 2
]

{ #category : 'accessing' }
OPUmlNameLabel >> defaultText [

	^ self modelElement name
]
