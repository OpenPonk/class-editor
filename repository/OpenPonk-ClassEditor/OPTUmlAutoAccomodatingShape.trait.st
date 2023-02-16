Trait {
	#name : #OPTUmlAutoAccomodatingShape,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> accomodateContents [

	| originalEncompassingRectangle extentOfContents |
	originalEncompassingRectangle := self roassalShape
		                                 encompassingRectangle.
	extentOfContents := self extentToFitContents max: self minExtent.
	self roassalShape extent: extentOfContents.
	(originalEncompassingRectangle height closeTo: extentOfContents y) 
		ifTrue: [ ^ self ].
	self roassalShape translateTo: self roassalShape position x
		@
		(originalEncompassingRectangle top + (self roassalShape height / 2))
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> bottomPadding [

	^ 0
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> extentToFit: anOwnedElement [

	^ (anOwnedElement respondsTo: #extentToFitContents)
		  ifTrue: [ anOwnedElement extentToFitContents ]
		  ifFalse: [ anOwnedElement extent ]
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> extentToFitContents [

	| totalHeight maxWidth |
	totalHeight := self topPadding + self bottomPadding.
	maxWidth := self leftPadding + self rightPadding.
	self ownedElements do: [ :each | 
		| extentOfEachContents |
		extentOfEachContents := self extentToFit: each.
		maxWidth := maxWidth max: extentOfEachContents x.
		totalHeight := totalHeight + extentOfEachContents y ].

	^ maxWidth @ totalHeight
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> leftPadding [

	^ 0
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> minExtent [

	^ 20 @ 10
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> rightPadding [

	^ 0
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> topPadding [

	^ 0
]
