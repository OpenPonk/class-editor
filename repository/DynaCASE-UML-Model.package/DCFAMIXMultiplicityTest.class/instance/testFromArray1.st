tests
testFromArray1
	| mul |
	mul := DCFAMIXMultiplicity fromArray: #(1).
	self assert: mul lower equals: 1.
	self assert: mul upper equals: 1