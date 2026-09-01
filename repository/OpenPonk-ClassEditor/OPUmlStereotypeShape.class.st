"
I am the diagram shape representing a UML Stereotype definition in a profile diagram. I inherit the visual structure of a Class but enforce stereotype-specific keywords and constraints.
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
