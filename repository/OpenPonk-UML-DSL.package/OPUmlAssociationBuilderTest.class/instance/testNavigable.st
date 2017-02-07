tests
testNavigable
	super testNavigable.
	self assert: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable