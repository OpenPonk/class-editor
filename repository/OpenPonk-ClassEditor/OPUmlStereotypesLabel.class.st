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

{ #category : #testing }
OPUmlStereotypesLabel >> isPositionableByUser [

	^ false
]

{ #category : #testing }
OPUmlStereotypesLabel >> isResizableByUser [

	^ false
]

{ #category : #accessing }
OPUmlStereotypesLabel >> stereotypeNames [

	^ self subclassResponsibility
]
