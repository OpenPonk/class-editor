Class {
	#name : #OPUmlClassifierNameLabel,
	#superclass : #OPUmlNameLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'as yet unclassified' }
OPUmlClassifierNameLabel >> createRoassalShape [

	self flag: #multiline.
	^ super createRoassalShape
]

{ #category : #'as yet unclassified' }
OPUmlClassifierNameLabel >> defaultEmphasis [

	^ self modelElement isAbstract
		  ifTrue: [ TextEmphasis italic ]
		  ifFalse: [ TextEmphasis normal ]
]

{ #category : #'as yet unclassified' }
OPUmlClassifierNameLabel >> defaultFontSize [

	^ 11
]

{ #category : #accessing }
OPUmlClassifierNameLabel >> defaultText [

	^ self modelElement name ifEmpty: [ ' ' ]
]
