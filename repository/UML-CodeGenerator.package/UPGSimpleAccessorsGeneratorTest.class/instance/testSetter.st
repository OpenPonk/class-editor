tests
testSetter
	self
		ast: (generator setter: uniToDept sourceEnd)
		equals:
			'university: anUniversity
			university := anUniversity'