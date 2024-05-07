Class {
	#name : 'OPUmlStereotypesLabel',
	#superclass : 'OPUmlKeywordLabel',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
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
