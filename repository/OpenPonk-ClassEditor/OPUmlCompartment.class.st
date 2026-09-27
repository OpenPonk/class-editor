"
A container shape representing a distinct compartment within a structured UML classifier shape, handling content layout and extent accommodation.
"
Class {
	#name : 'OPUmlCompartment',
	#superclass : 'OPUmlCompartmentableContent',
	#traits : 'OPTUmlAutoAccomodatingShape',
	#classTraits : 'OPTUmlAutoAccomodatingShape classTrait',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'rendering' }
OPUmlCompartment >> renderBasicShape [

	^ RSBox new
		  color: Color transparent;
		  yourself
]

{ #category : 'sorting' }
OPUmlCompartment >> sortOwnedElements [

	"do nothing by default"

	
]

{ #category : 'accessing' }
OPUmlCompartment >> top [

	^ self roassalShape encompassingRectangle top
]

{ #category : 'rendering' }
OPUmlCompartment >> updateRenderFromModel [

	super updateRenderFromModel.

	self accomodateContents
]

{ #category : 'accessing' }
OPUmlCompartment >> width: aNumber [
	"Sets the width of the underlying compartment Roassal shape."

	self roassalShape ifNotNil: [ :currentShape |
		currentShape width: aNumber ]
]

{ #category : 'geometry' }
OPUmlCompartment >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle left + (self width / 2)
	  + self leftPadding
]
