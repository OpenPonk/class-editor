as yet unclassified
testFamixMethod
	| model |
	model := FAMIXMethod named: 'Something'.
	class addFamixMethod: model.

	self assert: class methodsBox figures size equals: 1.
	self assert: class methodsBox figures first model equals: model