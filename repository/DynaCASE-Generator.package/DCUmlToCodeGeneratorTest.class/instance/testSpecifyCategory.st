tests
testSpecifyCategory
	model := FAMIXClass named: 'SomethingGenerated'.
	generator defaultCategory: 'Somewhere'.
	cls := generator createClassFor: model.
	self assert: cls category equals: 'Somewhere'.
	cls removeFromSystem