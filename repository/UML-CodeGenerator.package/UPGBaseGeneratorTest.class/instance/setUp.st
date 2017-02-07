running
setUp
	super setUp.
	factory := OPUmlDSLFactory new.
	self suspendedDo: [ RPackage organizer registerPackageNamed: self categoryName ]