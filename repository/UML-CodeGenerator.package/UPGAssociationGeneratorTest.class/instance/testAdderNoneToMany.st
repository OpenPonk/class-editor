tests
testAdderNoneToMany
	self
		ast: (generator adder: noneToMany targetEnd)
		equals:
			'addName: aName
	(names includes: aName) ifTrue: [ ^ self ].
	names add: aName'