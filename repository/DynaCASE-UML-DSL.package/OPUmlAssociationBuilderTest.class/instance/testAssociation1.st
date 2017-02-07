tests
testAssociation1
	super testAssociation1.
	self assert: result class equals: DCFAMIXBinaryAssociation.
	self assert: result source name equals: 'Left'.
	self assert: result target name equals: 'Right'.
	self assert: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable