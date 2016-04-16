tests
testSetterOneToMany
	self
		ast: (generator setter: oneToMany targetEnd)
		equals:
			'departments: aCollection
	[ departments isNotEmpty ] whileTrue: [ self removeDepartment: departments anyOne ].
	aCollection do: [ :each | self addDepartment: each ]'