Class {
	#name : 'OPUmlExtensionRequiredLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'as yet unclassified' }
OPUmlExtensionRequiredLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintEndDistanceReference distance: 10
]

{ #category : 'as yet unclassified' }
OPUmlExtensionRequiredLabel >> defaultMinDistance [

	^ super defaultMinDistance negated
]

{ #category : 'accessing' }
OPUmlExtensionRequiredLabel >> defaultText [

	^ self modelElement isRequired
		  ifTrue: [ '{required}' ]
		  ifFalse: [ '' ]
]
