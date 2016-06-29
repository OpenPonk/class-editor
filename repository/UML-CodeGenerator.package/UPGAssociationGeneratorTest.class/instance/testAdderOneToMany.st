tests
testAdderOneToMany
	self
		ast: (generator adder: oneToMany targetEnd)
		equals:
			'addDepartment: aDepartment
	(departments includes: aDepartment) ifTrue: [ ^ self ].
	departments add: aDepartment.
	aDepartment university: self'