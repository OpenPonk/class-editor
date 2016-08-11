tests
testFromString1
	| mul |
	mul := DCFAMIXMultiplicity fromString: '5'.
	self assert: mul lower equals: 5.
	self assert: mul upper equals: 5