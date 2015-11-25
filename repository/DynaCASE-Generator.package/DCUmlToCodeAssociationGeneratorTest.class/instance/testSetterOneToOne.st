tests
testSetterOneToOne
	result := generator setter: oneToOne targetEnd.
	self
		ast: result
		equals:
			'university: anUniversity
		|oldRef|
		university = anUniversity ifTrue: [ ^ self ].
		oldRef := university.
		university := anUniversity.
		oldRef ifNotNil: [ oldRef president: nil ].
		university ifNotNil: [ university president: self ]'