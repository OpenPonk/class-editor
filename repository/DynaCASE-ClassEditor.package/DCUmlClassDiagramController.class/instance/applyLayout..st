ui hooks
applyLayout: aThreeArgBlock
	| classes inheritance associations |
	classes := self controllers
		select: [ :ctrl | ctrl isMemberOf: DCUmlClassController ]
		thenCollect: #figure.
	inheritance := self controllers
		select: [ :ctrl | ctrl isMemberOf: DCUmlInheritanceController ]
		thenCollect: #figure.
	associations := self controllers
		select: [ :ctrl | ctrl isMemberOf: DCUmlAssociationController ]
		thenCollect: #figure.
	aThreeArgBlock value: classes value: inheritance value: associations.
	self view signalUpdate