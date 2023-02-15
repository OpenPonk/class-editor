Class {
	#name : #OPUmlCompartment,
	#superclass : #OPUmlCompartmentableContent,
	#traits : 'OPTUmlAutoAccomodatingShape',
	#classTraits : 'OPTUmlAutoAccomodatingShape classTrait',
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPUmlCompartment >> renderBasicShape [

	roassalShape := RSBox new
		                color: Color transparent;
		                yourself
]

{ #category : #sorting }
OPUmlCompartment >> sortOwnedElements [

	"do nothing by default"

	
]

{ #category : #rendering }
OPUmlCompartment >> updateRenderFromModel [

	super updateRenderFromModel.

	self accomodateContents
]

{ #category : #'as yet unclassified' }
OPUmlCompartment >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle left + (self width / 2)
]
