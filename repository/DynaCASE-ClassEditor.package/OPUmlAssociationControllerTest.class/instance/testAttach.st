tests
testAttach
	| association ac |
	association := OPFAMIXBinaryAssociation source: source target: target.
	ac := self controllerClass new.
	ac model: association.
	self assert: (targetController canBeTargetFor: ac).
	self assert: (sourceController canBeSourceFor: ac).
	sourceController addAsSourceFor: ac.
	targetController addAsTargetFor: ac.
	self assert: diagramController controllers size equals: 3.
	self assert: diagramController controllers last equals: ac.
	self assert: diagramController model allBinaryAssociations first equals: association