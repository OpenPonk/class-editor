running
setUp
	super setUp.
	generator := UPGDirectAssociationGenerator new.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel