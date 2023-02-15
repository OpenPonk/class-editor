Class {
	#name : #OPUmlCommentIcon,
	#superclass : #OPUmlCompartmentableContent,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPUmlCommentIcon >> renderBasicShape [

	roassalShape := RSBitmap new
		                form: (self iconNamed: #announcement);
		                yourself
]

{ #category : #'as yet unclassified' }
OPUmlCommentIcon >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle right - (self width / 2)
]
