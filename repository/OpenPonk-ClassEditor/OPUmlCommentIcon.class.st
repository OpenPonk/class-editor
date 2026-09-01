"
I am a visual UI component representing a comment icon, designed to be embedded within a compartment or attached to a shape.
"
Class {
	#name : 'OPUmlCommentIcon',
	#superclass : 'OPUmlCompartmentableContent',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
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

	| iconGroup |
	iconGroup := self iconFormSetNamed: #announcement.

	^ RSBitmap new
		  form: (iconGroup asFormAtScale: 2);
		  extent: iconGroup extent;
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

{ #category : 'geometry' }
OPUmlCommentIcon >> xCoordinateForOwner [

	^ self owningElement encompassingRectangle right - (self width / 2)
	  - self rightPadding
]
