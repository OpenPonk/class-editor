"
I represent a direct generalization line.
"
Class {
	#name : #OPUmlGeneralizationShape,
	#superclass : #OPUmlEdge,
	#instVars : [
		'nameLabel',
		'constraints'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #initialization }
OPUmlGeneralizationShape >> initialize [

	super initialize.
	self headDecorator: OPUmlEdgeMarkers emptyArrow.
	nameLabel := OPUmlGeneralizationLabel
		             in: self
		             forModelElement: self modelElement.
	constraints := OrderedCollection new
]

{ #category : #accessing }
OPUmlGeneralizationShape >> modelElement: anObject [
	super modelElement: anObject.
	nameLabel modelElement: anObject.
]

{ #category : #testing }
OPUmlGeneralizationShape >> showIncomplete [
	^ false
]

{ #category : #testing }
OPUmlGeneralizationShape >> showOverlapping [
	^ false
]

{ #category : #'Roassal2 - updating' }
OPUmlGeneralizationShape >> update [
	self rtEdge shape color: self style strokeColor.
	self rtEdge update.
	constraints do: #update.
	self ownedElements do: #update
]
