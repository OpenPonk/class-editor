as yet unclassified
testFamixAttribute
	| model |
	model := FAMIXAttribute named: 'Something'.
	class addFamixAttribute: model.

	self assert: class attributesBox figures size equals: 1.
	self assert: class attributesBox figures first model equals: model