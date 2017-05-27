tests
testRemove
	| association |
	self skip: 'to be removed anyway'.
	association := OPFAMIXBinaryAssociation source: source target: target.
	diagramController model add: association.
	diagramController rebuild.
	self assert: target incomingAssociations size equals: 1.
	self assert: source outgoingAssociations size equals: 1.
	diagramController removeFromModel: association.
	self assert: target incomingAssociations size equals: 0.
	self assert: source outgoingAssociations size equals: 0.
	self assert: diagramController controllers size equals: 2.
	self assert: diagramController model allBinaryAssociations size equals: 0