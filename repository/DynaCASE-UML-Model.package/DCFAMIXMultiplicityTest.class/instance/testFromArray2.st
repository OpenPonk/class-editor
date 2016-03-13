tests
testFromArray2
	| mul |
	mul := DCFAMIXMultiplicity fromArray: #(2 3).
	self assert: mul lower equals: 2.
	self assert: mul upper equals: 3