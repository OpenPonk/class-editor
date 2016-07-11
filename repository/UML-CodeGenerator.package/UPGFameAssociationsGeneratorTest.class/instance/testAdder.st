tests
testAdder
	self
		ast: (generator adder: uniToDept targetEnd)
		equals:
			'addDepartment: aDepartment
			departments add: aDepartment'