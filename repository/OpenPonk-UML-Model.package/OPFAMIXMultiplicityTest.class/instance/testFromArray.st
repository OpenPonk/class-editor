tests
testFromArray
	| mul |
	mul := OPFAMIXMultiplicity fromArray: #(1 #*).
	self assert: mul lower equals: 1.
	self assert: mul upper equals: OPUnlimitedNatural max