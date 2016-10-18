ui hooks
applyLayout: aThreeArgBlock
	| classes inheritance associations |
	classes := self controllers
		select: [ :ctrl | ctrl isKindOf: DCUmlClassController ]
		thenCollect: #figure.
	inheritance := self controllers
		select: [ :ctrl | ctrl isKindOf: DCUmlInheritanceController ]
		thenCollect: #figure.
	associations := self controllers
		select: [ :ctrl | ctrl isKindOf: DCUmlAssociationController ]
		thenCollect: #figure.
	aThreeArgBlock value: classes value: inheritance value: associations.
	self view signalUpdate