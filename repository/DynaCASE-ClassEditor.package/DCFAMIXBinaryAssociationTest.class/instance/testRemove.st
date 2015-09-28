tests
testRemove
	| from to association |
	from := FAMIXClass named: 'from'.
	to := FAMIXClass named: 'to'.
	association := DCFAMIXBinaryAssociation source: from target: to.

	association target: nil.
	self assert: to incomingAssociations size equals: 0.

	association source: nil.
	self assert: from outgoingAssociations size equals: 0