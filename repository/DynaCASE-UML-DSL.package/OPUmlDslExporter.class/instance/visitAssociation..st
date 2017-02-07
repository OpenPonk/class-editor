visitor
visitAssociation: anAssociation
	self visitType: anAssociation source withMultiplicity: anAssociation sourceEnd multiplicity separator: ''.
	stream nextPut: Character space.
	anAssociation sourceEnd name
		ifNotNil: [ :n | 
			stream
				nextPutAll: n;
				nextPut: Character space ].
	anAssociation targetEnd aggregation = DCUmlAggregationKind shared
		ifTrue: [ stream nextPutAll: '<>' ].
	anAssociation targetEnd aggregation = DCUmlAggregationKind composite
		ifTrue: [ stream nextPutAll: '<*>' ].
	anAssociation targetEnd aggregation = DCUmlAggregationKind none
		ifTrue: [ (anAssociation sourceEnd isNavigable not or: [ anAssociation targetEnd isNavigable ])
				ifTrue: [ stream nextPut: $- ]
				ifFalse: [ stream nextPut: $< ] ].
	stream nextPut: $-.
	anAssociation sourceEnd aggregation = DCUmlAggregationKind shared
		ifTrue: [ stream nextPutAll: '<>' ].
	anAssociation sourceEnd aggregation = DCUmlAggregationKind composite
		ifTrue: [ stream nextPutAll: '<*>' ].
	anAssociation sourceEnd aggregation = DCUmlAggregationKind none
		ifTrue: [ (anAssociation targetEnd isNavigable not or: [ anAssociation sourceEnd isNavigable ])
				ifTrue: [ stream nextPut: $- ]
				ifFalse: [ stream nextPut: $> ] ].
	stream nextPut: Character space.
	anAssociation targetEnd name
		ifNotNil: [ :n | 
			stream
				nextPutAll: n;
				nextPut: Character space ].
	self visitType: anAssociation target withMultiplicity: anAssociation targetEnd multiplicity separator: ''.
	anAssociation name
		ifNotEmpty: [ :n | 
			stream
				nextPutAll: ' : ';
				nextPutAll: n ].
	stream nextPut: $;