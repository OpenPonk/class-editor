tests
testBuild2
	| association |
	association := OPFAMIXBinaryAssociation source: target target: source.
	diagramController model add: association.
	diagramController rebuild.
	self assert: diagramController controllers size equals: 3.
	self
		assertCollection: (diagramController controllers collect: #model)
		hasSameElements:
			{association.
			association from.
			association to}