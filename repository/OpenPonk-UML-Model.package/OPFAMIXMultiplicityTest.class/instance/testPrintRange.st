tests-printing
testPrintRange
	self assert: OPFAMIXMultiplicity zeroToMany printRange equals: '[*]'.
	self assert: OPFAMIXMultiplicity oneToMany printRange equals: '[1..*]'.
	self assert: OPFAMIXMultiplicity one printRange equals: '[1]'.
	self assert: OPFAMIXMultiplicity zeroToOne printRange equals: '[0..1]'