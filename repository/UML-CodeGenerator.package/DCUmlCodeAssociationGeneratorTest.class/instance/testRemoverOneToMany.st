tests
testRemoverOneToMany
	self
		ast: (generator remover: oneToMany targetEnd)
		equals:
			'removeDepartment: aDepartment
	(departments includes: aDepartment) ifFalse: [ ^ self ].
	departments remove: aDepartment.
	aDepartment university: nil'