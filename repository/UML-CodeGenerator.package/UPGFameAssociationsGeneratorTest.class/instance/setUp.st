running
setUp
	super setUp.
	generator := self generatorClass new.
	generator context useEagerInitialization.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel