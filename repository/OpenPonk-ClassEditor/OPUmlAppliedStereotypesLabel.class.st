Class {
	#name : 'OPUmlAppliedStereotypesLabel',
	#superclass : 'OPUmlStereotypesLabel',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'accessing' }
OPUmlAppliedStereotypesLabel >> stereotypeNames [

	^ self modelElement appliedStereotypes collect: #umlClassName
]
