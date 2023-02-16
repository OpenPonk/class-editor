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

{ #category : #rendering }
OPUmlCompartment >> renderShapeDetails [

	self roassalShape when: RSPositionChangedEvent do: [ :event | 
		self ownedElements do: [ :each | 
			each translateBy: event newPosition - event oldPosition ] ]
]

{ #category : #sorting }
OPUmlCompartment >> sortOwnedElements [

	"do nothing by default"

	
]

{ #category : #accessing }
OPUmlCompartment >> top [

	^ self roassalShape encompassingRectangle top
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
