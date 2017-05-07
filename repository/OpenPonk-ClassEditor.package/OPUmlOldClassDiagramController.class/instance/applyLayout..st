ui hooks
applyLayout: aThreeArgBlock
	| classes inheritance associations |
	classes := self controllers
		select: [ :ctrl | ctrl isKindOf: OPUmlOldClassController ]
		thenCollect: #figure.
	inheritance := self controllers
		select: [ :ctrl | ctrl isKindOf: OPUmlOldInheritanceController ]
		thenCollect: #figure.
	associations := self controllers
		select: [ :ctrl | ctrl isKindOf: OPUmlOldAssociationController ]
		thenCollect: #figure.
	aThreeArgBlock value: classes value: inheritance value: associations.
	self view signalUpdate