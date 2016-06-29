tests
testSetter1
	self
		ast: (generator setter: uniToDept targetEnd)
		equals:
			'departments: aCollection
			departments := aCollection'