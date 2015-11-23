tests
testFigures1
	| lbl |
	(lbl := DCUmlLabel new) owningElement: element.

	self assert: element figures asArray equals: {lbl}