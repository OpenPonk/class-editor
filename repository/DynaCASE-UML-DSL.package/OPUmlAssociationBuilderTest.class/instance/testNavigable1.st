tests
testNavigable1
	super testNavigable1.
	self deny: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable