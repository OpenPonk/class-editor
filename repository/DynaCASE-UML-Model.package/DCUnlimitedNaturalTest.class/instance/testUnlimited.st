as yet unclassified
testUnlimited
	| num |
	num := DCUnlimitedNatural unlimited.
	self assert: num value equals: DCUnlimitedNatural max.
	self assert: num isUnlimited