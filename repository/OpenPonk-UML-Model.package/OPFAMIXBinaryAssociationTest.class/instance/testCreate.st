tests
testCreate
	| from to association |
	from := FAMIXClass named: 'from'.
	to := FAMIXClass named: 'to'.
	association := OPFAMIXBinaryAssociation source: from target: to.
	self assert: from incomingAssociations size equals: 0.
	self assert: from outgoingAssociations size equals: 1.
	self assert: from outgoingAssociations first equals: association.
	self assert: to incomingAssociations size equals: 1.
	self assert: to outgoingAssociations size equals: 0.
	self assert: to incomingAssociations first equals: association