tests
testBuild
	| association |
	association := DCFAMIXBinaryAssociation source: source target: target.
	diagramController model add: association.
	diagramController rebuild.
	self assert: diagramController controllers size equals: 3.
	self
		assertCollection: diagramController model entities
		hasSameElements:
			{source.
			target.
			association}.
	self assert: diagramController model entities size equals: 3.
	self
		assertCollection: (diagramController controllers collect: #model)
		hasSameElements:
			{association.
			association from.
			association to}