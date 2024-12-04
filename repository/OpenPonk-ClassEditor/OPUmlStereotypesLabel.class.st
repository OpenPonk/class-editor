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

{ #category : 'testing' }
OPUmlStereotypesLabel >> isPositionableByUser [

	^ false
]

{ #category : 'accessing' }
OPUmlStereotypesLabel >> stereotypeNames [

	^ self subclassResponsibility
]
