tests
testPrintRange
	self assert: DCFAMIXMultiplicity zeroToMany printRange equals: '[*]'.
	self assert: DCFAMIXMultiplicity oneToMany printRange equals: '[1..*]'.
	self assert: DCFAMIXMultiplicity one printRange equals: '[1]'.
	self assert: DCFAMIXMultiplicity zeroToOne printRange equals: '[0..1]'