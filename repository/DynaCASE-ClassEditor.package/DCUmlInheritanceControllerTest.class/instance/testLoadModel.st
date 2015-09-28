tests
testLoadModel
	| ic model |
	model := FAMIXInheritance new.
	ic := DCUmlInheritanceController new.
	ic model: model.
	ic loadModel.
	self assert: ic model equals: model