tests-printing
testPrintFullRange
	self assert: OPFAMIXMultiplicity zeroToMany printFullRange equals: '0..*'.
	self assert: OPFAMIXMultiplicity oneToMany printFullRange equals: '1..*'.
	self assert: OPFAMIXMultiplicity one printFullRange equals: '1..1'.
	self assert: OPFAMIXMultiplicity zeroToOne printFullRange equals: '0..1'