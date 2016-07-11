tests
testSetterMany
	self skip: 'not yet implemented'.
	self
		ast: (generator setter: uniToDept targetEnd)
		equals:
			'departments: aCollection
			departments value: aCollection'