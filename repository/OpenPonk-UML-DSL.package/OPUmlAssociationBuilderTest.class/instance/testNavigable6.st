tests
testNavigable6
	super testNavigable6.
	self assert: result sourceEnd isNavigable.
	self deny: result targetEnd isNavigable