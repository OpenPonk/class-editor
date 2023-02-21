Class {
	#name : #OPUmlStereotypesLabel,
	#superclass : #OPUmlKeywordLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlStereotypesLabel >> defaultText [

	^ self stereotypeNames
		  ifEmpty: [ '' ]
		  ifNotEmpty: [ :vals | '«' , (vals joinUsing: ', ') , '»' ]
]

{ #category : #accessing }
OPUmlStereotypesLabel >> stereotypeNames [

	^ self subclassResponsibility
]
