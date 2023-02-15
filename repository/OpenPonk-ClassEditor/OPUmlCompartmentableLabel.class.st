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
		                color: Color transparent;
		                yourself
]

{ #category : #'as yet unclassified' }
OPUmlCompartmentableLabel >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle center x
]
