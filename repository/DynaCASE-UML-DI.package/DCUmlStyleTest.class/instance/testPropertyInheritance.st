accessing
testPropertyInheritance
	| a b aStyle bShared bLocal |
	a := DCUmlDiagramElement new.
	(b := DCUmlDiagramElement new) owningElement: a.
	(aStyle := DCUmlStyle new) fontSize: 15.
	a sharedStyle: aStyle.
	self assert: b style fontSize equals: 15.
	bShared := DCUmlStyle new.
	b sharedStyle: bShared.
	self assert: b style fontSize equals: 15.
	bShared fontSize: 20.
	self assert: b style fontSize equals: 20.
	bLocal := DCUmlStyle new.
	b localStyle: bLocal.
	self assert: b style fontSize equals: 20.
	bLocal fontSize: 25.
	self assert: b style fontSize equals: 25.
	bLocal removeKey: #fontSize.
	self assert: b style fontSize equals: 20.
	bShared removeKey: #fontSize.
	self assert: b style fontSize equals: 15