"
I am a specific stereotypes label responsible for fetching and displaying the dynamic list of custom stereotypes actively applied to a given UML element.
"
Class {
	#name : 'OPUmlAppliedStereotypesLabel',
	#superclass : 'OPUmlStereotypesLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPUmlAppliedStereotypesLabel >> stereotypeNames [

	^ self modelElement appliedStereotypes collect: #umlClassName
]
