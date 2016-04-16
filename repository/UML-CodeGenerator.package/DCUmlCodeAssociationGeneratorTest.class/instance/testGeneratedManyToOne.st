tests
testGeneratedManyToOne
	generator resolveAssociationEnd: oneToMany targetEnd in: cls.
	self assert: cls instVarNames equals: #(#departments).
	self
		assert: cls selectors asSet
		equals: #(#departments #departments: #addDepartment: #removeDepartment: #initialize) asSet