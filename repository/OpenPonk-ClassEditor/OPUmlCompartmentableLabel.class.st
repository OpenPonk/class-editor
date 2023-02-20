Class {
	#name : #OPUmlCompartmentableLabel,
	#superclass : #OPUmlCompartmentableContent,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #accessing }
OPUmlCompartmentableLabel >> extent [

	^ self ownedElements anyOne extent
]

{ #category : #rendering }
OPUmlCompartmentableLabel >> renderBasicShape [

	roassalShape := RSBox new
		                color: (Color
				                 r: 1
				                 g: 0
				                 b: 0
				                 alpha: 0.4);
		                yourself
]

{ #category : #rendering }
OPUmlCompartmentableLabel >> renderShapeDetails [

	self roassalShape when: RSPositionChangedEvent do: [ :event | 
		self ownedElements do: [ :each | 
			each translateBy: event newPosition - event oldPosition ] ]
]

{ #category : #'as yet unclassified' }
OPUmlCompartmentableLabel >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle center x
]
