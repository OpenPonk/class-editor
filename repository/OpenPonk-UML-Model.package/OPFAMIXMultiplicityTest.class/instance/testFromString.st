tests
testFromString
	| mul |
	mul := OPFAMIXMultiplicity fromString: '2..*'.
	self assert: mul lower equals: 2.
	self assert: mul upper equals: OPUnlimitedNatural max