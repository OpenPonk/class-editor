tests
testSetValue
	| num |
	num := OPUnlimitedNatural new.
	self assert: num value equals: 0.
	self deny: num isUnlimited.
	num value: 20.
	self assert: num value equals: 20.
	self deny: num isUnlimited