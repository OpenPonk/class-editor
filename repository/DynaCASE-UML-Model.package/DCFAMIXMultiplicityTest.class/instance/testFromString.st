tests
testFromString
	| mul |
	mul := DCFAMIXMultiplicity fromString: '2..*'.
	self assert: mul lower equals: 2.
	self assert: mul upper equals: DCUnlimitedNatural max