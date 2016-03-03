tests
testBeUnlimited
	| num |
	num := DCUnlimitedNatural new.
	self deny: num isUnlimited.
	num beUnlimited.
	self assert: num isUnlimited