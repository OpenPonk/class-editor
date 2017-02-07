visitor
visitAssociation: anAssociation
	self visitType: anAssociation source withMultiplicity: anAssociation sourceEnd multiplicity separator: ''.
	stream nextPut: Character space.
	anAssociation sourceEnd name
		ifNotNil: [ :n | 
			stream
				nextPutAll: n;
				nextPut: Character space ].
	anAssociation targetEnd aggregation = OPUmlAggregationKind shared
		ifTrue: [ stream nextPutAll: '<>' ].
	anAssociation targetEnd aggregation = OPUmlAggregationKind composite
		ifTrue: [ stream nextPutAll: '<*>' ].
	anAssociation targetEnd aggregation = OPUmlAggregationKind none
		ifTrue: [ (anAssociation sourceEnd isNavigable not or: [ anAssociation targetEnd isNavigable ])
				ifTrue: [ stream nextPut: $- ]
				ifFalse: [ stream nextPut: $< ] ].
	stream nextPut: $-.
	anAssociation sourceEnd aggregation = OPUmlAggregationKind shared
		ifTrue: [ stream nextPutAll: '<>' ].
	anAssociation sourceEnd aggregation = OPUmlAggregationKind composite
		ifTrue: [ stream nextPutAll: '<*>' ].
	anAssociation sourceEnd aggregation = OPUmlAggregationKind none
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