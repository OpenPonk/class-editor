visitor
elementAt: anId
	(elements at: anId) isBlock
		ifTrue: [ elements at: anId put: (elements at: anId) value ].
	^ elements at: anId