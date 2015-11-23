tests
testFigures3
	| lbl comp compLbl |
	(lbl := DCUmlLabel new) owningElement: element.
	(comp := DCUmlCompartment new) owningElement: element.
	(compLbl := DCUmlLabel new) owningElement: comp.

	self assert: element figures asArray equals: (Array with: lbl with: compLbl)