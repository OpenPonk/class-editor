Class {
	#name : #OPUmlStereotypeLabel,
	#superclass : #OPUmlKeywordLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlStereotypeLabel >> defaultText [

	^ (self modelElement appliedStereotypes collect: #umlClassName)
		  ifEmpty: [ '' ]
		  ifNotEmpty: [ :vals | '«' , (vals joinUsing: ', ') , '»' ]
]
