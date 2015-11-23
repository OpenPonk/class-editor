accessing
testLocalStyleNotInherited
	| a b |
	a := DCUmlDiagramElement new.
	(b := DCUmlDiagramElement new) owningElement: a.
	self assert: a style equals: nil.
	self assert: b style equals: nil.
	a localStyle: element.
	self assert: a style equals: element.
	self assert: b style equals: nil