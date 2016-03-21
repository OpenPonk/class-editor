tests
testOpposite
	| from to association |
	from := FAMIXClass named: 'from'.
	to := FAMIXClass named: 'to'.
	association := DCFAMIXBinaryAssociation source: from target: to.
	self assert: association sourceEnd opposite equals: association targetEnd.
	self assert: association targetEnd opposite equals: association sourceEnd