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
