tests-printing
testPrintFullRange
	self assert: DCFAMIXMultiplicity zeroToMany printFullRange equals: '0..*'.
	self assert: DCFAMIXMultiplicity oneToMany printFullRange equals: '1..*'.
	self assert: DCFAMIXMultiplicity one printFullRange equals: '1..1'.
	self assert: DCFAMIXMultiplicity zeroToOne printFullRange equals: '0..1'