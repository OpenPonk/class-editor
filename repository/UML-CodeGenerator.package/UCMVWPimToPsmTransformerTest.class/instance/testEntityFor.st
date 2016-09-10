tests
testEntityFor
	pim := FAMIXClass named: 'item'.
	psm := transformer entityFor: pim.
	self deny: pim = psm.
	self assert: psm class equals: pim class.
	self assert: psm name equals: pim name