running
setUp
	super setUp.
	factory := DCUmlDSLFactory new.
	self suspendedDo: [ RPackage organizer registerPackageNamed: self categoryName ]