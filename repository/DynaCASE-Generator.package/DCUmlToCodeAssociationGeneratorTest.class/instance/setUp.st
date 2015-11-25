running
setUp
	super setUp.
	generator := DCUmlToCodeAssociationGenerator new.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel