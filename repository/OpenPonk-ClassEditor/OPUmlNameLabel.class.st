Class {
	#name : #OPUmlNameLabel,
	#superclass : #OPUmlLabel,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #accessing }
OPUmlNameLabel class >> priority [
	^ 2
]

{ #category : #accessing }
OPUmlNameLabel >> defaultText [

	^ self modelElement name
]
