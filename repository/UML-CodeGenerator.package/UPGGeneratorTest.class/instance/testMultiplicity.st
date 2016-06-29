tests
testMultiplicity
	self assert: (generator multiplicityFor: DCFAMIXMultiplicity zeroToOne) equals: #(0 1).
	self assert: (generator multiplicityFor: DCFAMIXMultiplicity one) equals: #(1).
	self assert: (generator multiplicityFor: DCFAMIXMultiplicity zeroToMany) equals: #(0 #*).
	self assert: (generator multiplicityFor: DCFAMIXMultiplicity oneToMany) equals: #(1 #*)