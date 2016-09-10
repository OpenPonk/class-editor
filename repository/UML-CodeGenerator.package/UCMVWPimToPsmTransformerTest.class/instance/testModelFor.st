tests
testModelFor
	pim := MooseModel named: 'hello'.
	psm := transformer modelFor: pim.
	self assert: psm class equals: pim class.
	self assert: psm name equals: 'hello (PSM)'