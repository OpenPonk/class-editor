running
setUp
	super setUp.
	generator := UPGSimpleAccessorsGenerator new.
	generator context useEagerInitialization.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel