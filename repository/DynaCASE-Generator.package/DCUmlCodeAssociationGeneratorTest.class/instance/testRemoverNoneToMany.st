tests
testRemoverNoneToMany
	self
		ast: (generator remover: noneToMany targetEnd)
		equals:
			'removeName: aName
	(names includes: aName) ifFalse: [ ^ self ].
	names remove: aName'