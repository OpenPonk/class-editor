tests
testGeneratedOneToMany
	generator resolveAssociationEnd: oneToMany sourceEnd in: cls.
	self assert: cls instVarNames equals: #(#university).
	self assert: cls selectors asSet equals: #(#university #university:) asSet