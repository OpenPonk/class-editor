"
I am the base label for displaying UML keywords and stereotypes (e.g., `<<metaclass>>` or `<<myStereotype>>`). I typically sit directly above the main element name.
"
Class {
	#name : 'OPUmlStereotypesLabel',
	#superclass : 'OPUmlKeywordLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPUmlStereotypesLabel >> defaultText [

	^ self stereotypeNames
		  ifEmpty: [ '' ]
		  ifNotEmpty: [ :vals | '«' , (vals joinUsing: ', ') , '»' ]
]

{ #category : 'interactions' }
OPUmlStereotypesLabel >> shouldBePositionableByUser [

	^ false
]

{ #category : 'accessing' }
OPUmlStereotypesLabel >> stereotypeNames [

	^ self subclassResponsibility
]
