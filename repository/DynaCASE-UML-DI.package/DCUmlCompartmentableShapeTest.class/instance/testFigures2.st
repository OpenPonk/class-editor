tests
testFigures2
	| lbl comp1 |
	(lbl := DCUmlLabel new) owningElement: element.
	(comp1 := DCUmlCompartment new) owningElement: element.

	self assert: element figures asArray equals: {lbl}