tests
testRemover
	self
		ast: (generator remover: uniToDept targetEnd)
		equals:
			'removeDepartment: aDepartment
			departments remove: aDepartment'