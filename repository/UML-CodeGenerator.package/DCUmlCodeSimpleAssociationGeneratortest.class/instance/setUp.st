running
setUp
	super setUp.
	generator := DCUmlCodeSimpleAssociationGenerator new.
	generator context useEagerInitialization.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel