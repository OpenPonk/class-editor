tests
testSetterOne
	self skip: 'not yet implemented'.
	self
		ast: (generator setter: uniToDept sourceEnd)
		equals:
			'university: anUniversity
			university := FMMultivalueLink
				on: self
				update: #departments
				from: university
				to: anUniversity'