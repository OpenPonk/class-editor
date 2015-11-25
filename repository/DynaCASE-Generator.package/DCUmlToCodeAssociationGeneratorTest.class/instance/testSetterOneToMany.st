tests
testSetterOneToMany
	result := generator setter: oneToMany targetEnd.
	self
		ast: result
		equals:
			'departments: aCollection
	[ departments isNotEmpty ] whileTrue: [ self removeDepartment: departments anyOne ].
	aCollection do: [ :each | self addDepartment: each ]'