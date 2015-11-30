tests
testRemoverManyToMany
	self
		ast: (generator remover: manyToMany targetEnd)
		equals:
			'removeTeacher: aTeacher
	(teachers includes: aTeacher) ifFalse: [ ^ self ].
	teachers remove: aTeacher.
	aTeacher removeMemberOf: self'