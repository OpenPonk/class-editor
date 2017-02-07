tests
testNavigable4
	super testNavigable4.
	self deny: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable