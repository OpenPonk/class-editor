tests
testAssociation3
	super testAssociation3.
	self assert: result source name equals: 'Left'.
	self assert: result target name equals: 'Right'.
	self assert: result sourceEnd name equals: 'leftRole'.
	self assert: result targetEnd name equals: 'rightRole'.
	self assert: result name equals: 'name'