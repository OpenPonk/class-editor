running
setUp
	super setUp.
	generator := DCUmlCodeAssociationGenerator new.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel