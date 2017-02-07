tests
testLoadModel
	| ic model |
	model := FAMIXInheritance new.
	ic := OPUmlInheritanceController new.
	ic model: model.
	ic loadModel.
	self assert: ic model equals: model