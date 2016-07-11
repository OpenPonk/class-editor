tests
testSetterMany
	self
		ast: (generator setter: uniToDept targetEnd)
		equals:
			'departments: aCollection
			departments value: aCollection'