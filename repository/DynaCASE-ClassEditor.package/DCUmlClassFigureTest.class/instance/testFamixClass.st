as yet unclassified
testFamixClass
	| model |
	model := FAMIXClass named: 'Something'.
	class famixClass: model.

	self assert: class model equals: model.
	self assert: class nameLabel model equals: model