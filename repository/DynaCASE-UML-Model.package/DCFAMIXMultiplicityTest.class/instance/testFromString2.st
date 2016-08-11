tests
testFromString2
	| mul |
	mul := DCFAMIXMultiplicity fromString: '*'.
	self assert: mul lower equals: 0.
	self assert: mul upper equals: DCUnlimitedNatural max