tests
testFromString2
	| mul |
	mul := OPFAMIXMultiplicity fromString: '*'.
	self assert: mul lower equals: 0.
	self assert: mul upper equals: OPUnlimitedNatural max