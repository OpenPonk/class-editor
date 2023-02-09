Class {
	#name : #OPUmlKeywordLabel,
	#superclass : #OPUmlLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlKeywordLabel class >> priority [
	^ 1
]

{ #category : #accessing }
OPUmlKeywordLabel >> defaultText [

	^ self owningElement stereotypeText
]
