"
I am a specialized label shape designed to be placed within a UML compartment, handling text rendering and layout relative to my container.
"
Class {
	#name : 'OPUmlCompartmentableLabel',
	#superclass : 'OPUmlCompartmentableContent',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPUmlCompartmentableLabel >> extent [

	^ self ownedElements anyOne extent
]

{ #category : 'accessing' }
OPUmlCompartmentableLabel >> hiddenPackages [

	^ self owningElement hiddenPackages
]

{ #category : 'rendering' }
OPUmlCompartmentableLabel >> renderBasicShape [

	^ RSBox new
		  color: Color transparent;
		  yourself
]

{ #category : 'rendering' }
OPUmlCompartmentableLabel >> renderShapeDetails [

	super renderShapeDetails.
	self roassalShape
		when: RSPositionChangedEvent
		do: [ :event |
			self ownedElements do: [ :each |
				each translateBy: event newPosition - event oldPosition ] ]
		for: self
]

{ #category : 'geometry' }
OPUmlCompartmentableLabel >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle center x
]
