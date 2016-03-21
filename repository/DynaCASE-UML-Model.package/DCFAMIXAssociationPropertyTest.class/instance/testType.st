tests
testType
	| from to association |
	from := FAMIXClass named: 'from'.
	to := FAMIXClass named: 'to'.
	association := DCFAMIXBinaryAssociation source: from target: to.
	self assert: association sourceEnd declaredType equals: from.
	self assert: association targetEnd declaredType equals: to