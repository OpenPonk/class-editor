Class {
	#name : #OPUmlAppliedStereotypesLabel,
	#superclass : #OPUmlStereotypesLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlAppliedStereotypesLabel >> stereotypeNames [

	^ self modelElement appliedStereotypes collect: #umlClassName
]
