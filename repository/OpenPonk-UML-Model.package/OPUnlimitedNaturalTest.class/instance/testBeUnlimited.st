tests
testBeUnlimited
	| num |
	num := OPUnlimitedNatural new.
	self deny: num isUnlimited.
	num beUnlimited.
	self assert: num isUnlimited