"
A diagram shape representing a UML Stereotype definition, inheriting classifier structure while enforcing profile-specific styling and keywords.
"
Class {
	#name : 'OPUmlStereotypeShape',
	#superclass : 'OPUmlClassShape',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'rendering' }
OPUmlStereotypeShape >> stereotypesLabelClass [

	^ OPUmlStereotypeOfStereotypeLabel
]
