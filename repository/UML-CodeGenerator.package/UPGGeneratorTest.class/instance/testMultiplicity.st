tests
testMultiplicity
	self
		assert:
			(generator multiplicityFor:
				OPFAMIXMultiplicity zeroToOne)
		equals: #(0 1).
	self
		assert:
			(generator multiplicityFor:
				OPFAMIXMultiplicity one)
		equals: #(1).
	self
		assert:
			(generator multiplicityFor:
				OPFAMIXMultiplicity zeroToMany)
		equals: #(0 *).
	self
		assert:
			(generator multiplicityFor:
				OPFAMIXMultiplicity oneToMany)
		equals: #(1 *)