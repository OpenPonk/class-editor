as yet unclassified
testNavigable2
	super testNavigable2.
	self assert: result sourceEnd isNavigable.
	self deny: result targetEnd isNavigable