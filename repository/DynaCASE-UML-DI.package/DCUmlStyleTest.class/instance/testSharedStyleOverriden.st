accessing
testSharedStyleOverriden
	| a b newStyle |
	a := DCUmlDiagramElement new.
	(b := DCUmlDiagramElement new) owningElement: a.
	a sharedStyle: element.
	self assert: a style equals: element.
	self assert: b style equals: element.
	newStyle := DCUmlStyle new.
	b localStyle: newStyle.
	self assert: b style equals: newStyle.
	self assert: b sharedStyle equals: element