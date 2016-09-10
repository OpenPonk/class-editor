public - transforming
generateFor: aPsmModel with: aContext
	| pim |
	pim := self modelFor: aPsmModel.
	self copyClassesFrom: aPsmModel to: pim.
	aPsmModel allBinaryAssociations do: [ :each | self createAssociationsFor: each ].
	^ pim