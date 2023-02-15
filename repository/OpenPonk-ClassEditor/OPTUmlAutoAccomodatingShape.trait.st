Trait {
	#name : #OPTUmlAutoAccomodatingShape,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> accomodateContents [

	| originalEncompassingRectangle extentOfContents |
	originalEncompassingRectangle := self roassalShape
		                                 encompassingRectangle.
	extentOfContents := self minExtent max: 20 @ 10.
	self roassalShape extent: extentOfContents.
	(originalEncompassingRectangle height closeTo: extentOfContents y) 
		ifTrue: [ ^ self ].
	self roassalShape translateTo: self roassalShape position x
		@
		(originalEncompassingRectangle top + (self roassalShape height / 2))
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> minExtent [

	| totalHeight maxWidth |
	totalHeight := 0.
	maxWidth := 0.
	self ownedElements do: [ :each | 
		| extentOfEachContents |
		extentOfEachContents := self minExtentFor: each.
		maxWidth := maxWidth max: extentOfEachContents x.
		totalHeight := totalHeight + extentOfEachContents y + 1 ].

	^ maxWidth @ totalHeight
]

{ #category : #rendering }
OPTUmlAutoAccomodatingShape >> minExtentFor: anOwnedElement [

	^ (anOwnedElement respondsTo: #minExtent)
		  ifTrue: [ anOwnedElement minExtent ]
		  ifFalse: [ anOwnedElement extent ]
]
