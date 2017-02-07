tests
testUnlimited
	| num |
	num := OPUnlimitedNatural unlimited.
	self assert: num value equals: OPUnlimitedNatural max.
	self assert: num isUnlimited