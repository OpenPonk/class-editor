Class {
	#name : #OPUmlAppliedStereotypesLabel,
	#superclass : #OPUmlStereotypesLabel,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #accessing }
OPUmlAppliedStereotypesLabel >> stereotypeNames [

	^ self modelElement appliedStereotypes collect: #umlClassName
]
