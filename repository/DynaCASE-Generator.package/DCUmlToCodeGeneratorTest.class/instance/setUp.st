running
setUp
	(generator := DCUmlToCodeGenerator new)
		withAccessors;
		defaultCategory: self categoryName.
	factory := DCUmlDSLFactory new.
	self suspendedDo: [ RPackage organizer registerPackageNamed: self categoryName ].
	cls := self newClassNamed: #SomethingGenerated