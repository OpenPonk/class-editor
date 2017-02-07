tests
testLoadModel
	| ac model |
	model := OPFAMIXBinaryAssociation new.
	ac := self controllerClass new.
	ac model: model.
	ac loadModel.
	self assert: ac model equals: model