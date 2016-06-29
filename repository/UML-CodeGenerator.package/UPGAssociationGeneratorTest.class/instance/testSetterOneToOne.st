tests
testSetterOneToOne
	self
		ast: (generator setter: oneToOne targetEnd)
		equals:
			'university: anUniversity
		|oldRef|
		university = anUniversity ifTrue: [ ^ self ].
		oldRef := university.
		university := anUniversity.
		oldRef ifNotNil: [ oldRef president: nil ].
		university ifNotNil: [ university president: self ]'