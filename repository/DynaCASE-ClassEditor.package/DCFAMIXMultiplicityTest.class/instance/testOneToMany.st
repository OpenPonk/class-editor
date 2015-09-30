tests
testOneToMany
	| mul |
	mul := DCFAMIXMultiplicity oneToMany.
	self assert: mul lower equals: 1.
	self assert: mul upper equals: DCUnlimitedNatural max