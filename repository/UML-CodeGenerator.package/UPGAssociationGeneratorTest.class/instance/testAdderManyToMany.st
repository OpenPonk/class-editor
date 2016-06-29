tests
testAdderManyToMany
	self
		ast: (generator adder: manyToMany targetEnd)
		equals:
			'addTeacher: aTeacher
	(teachers includes: aTeacher) ifTrue: [ ^ self ].
	teachers add: aTeacher.
	aTeacher addMemberOf: self'