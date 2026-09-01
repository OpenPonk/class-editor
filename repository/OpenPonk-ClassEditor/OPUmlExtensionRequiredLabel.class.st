"
I am a specialized edge label for UML Extensions. I am used to visually indicate whether the extension is required by displaying `{required}` near the stereotype end.
"
Class {
	#name : 'OPUmlExtensionRequiredLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlExtensionRequiredLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintEndDistanceReference distance: 10
]

{ #category : 'adding' }
OPUmlExtensionRequiredLabel >> defaultMinDistance [

	^ super defaultMinDistance negated
]

{ #category : 'accessing' }
OPUmlExtensionRequiredLabel >> defaultText [

	^ self modelElement isRequired
		  ifTrue: [ '{required}' ]
		  ifFalse: [ '' ]
]
