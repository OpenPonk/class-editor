Class {
	#name : #OPUmlCompartmentableLabel,
	#superclass : #OPUmlCompartmentableContent,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #accessing }
OPUmlCompartmentableLabel >> extent [

	^ self ownedElements anyOne extent
]

{ #category : #rendering }
OPUmlCompartmentableLabel >> renderBasicShape [

	^ RSBox new
		  color: Color transparent;
		  yourself
]

{ #category : #rendering }
OPUmlCompartmentableLabel >> renderShapeDetails [

	super renderShapeDetails.
	self roassalShape
		when: RSPositionChangedEvent
		do: [ :event |
			self ownedElements do: [ :each |
				each translateBy: event newPosition - event oldPosition ] ]
		for: self
]

{ #category : #'as yet unclassified' }
OPUmlCompartmentableLabel >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle center x
]
