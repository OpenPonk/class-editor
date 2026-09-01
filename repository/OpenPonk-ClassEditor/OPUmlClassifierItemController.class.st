"
I am the base controller for items owned by a classifier (e.g., attributes or operations). I ensure that my visual representation is correctly added to my owner's diagram element rather than the main canvas.
"
Class {
	#name : 'OPUmlClassifierItemController',
	#superclass : 'OPUmlElementController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'adding' }
OPUmlClassifierItemController >> addDiagramElementToOwner [

	self subclassResponsibility
]

{ #category : 'construction' }
OPUmlClassifierItemController >> createDiagramElement [

	self diagramElement:
		(self diagramElementClass forModelElement: self model).

	self addDiagramElementToOwner.

	^ self diagramElement
]
