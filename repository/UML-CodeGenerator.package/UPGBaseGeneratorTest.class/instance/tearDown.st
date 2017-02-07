running
tearDown
	super tearDown.
	self
		suspendedDo:
			[ (RPackage organizer packageNamed: 'OpenPonk-GeneratorTest') classes
				do: [ :each | each removeFromSystemUnlogged ] ]