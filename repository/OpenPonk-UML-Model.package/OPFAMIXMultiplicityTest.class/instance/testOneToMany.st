tests
testOneToMany
	| mul |
	mul := OPFAMIXMultiplicity oneToMany.
	self assert: mul lower equals: 1.
	self assert: mul upper equals: OPUnlimitedNatural max