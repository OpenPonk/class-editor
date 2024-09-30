Class {
	#name : 'OPUmlCommentIcon',
	#superclass : 'OPUmlCompartmentableContent',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'rendering' }
OPUmlCommentIcon >> bottomPadding [

	^ 2
]

{ #category : 'rendering' }
OPUmlCommentIcon >> extentToFitContents [

	^ self extent
	  + (self rightPadding @ (self topPadding + self bottomPadding))
]

{ #category : 'rendering' }
OPUmlCommentIcon >> renderBasicShape [

	^ RSBitmap new
		  form: (self iconNamed: #announcement);
		  yourself
]

{ #category : 'rendering' }
OPUmlCommentIcon >> rightPadding [

	^ 5
]

{ #category : 'rendering' }
OPUmlCommentIcon >> topPadding [

	^ 2
]

{ #category : 'as yet unclassified' }
OPUmlCommentIcon >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle right - (self width / 2)
	  - self rightPadding
]
