running
setUp
	super setUp.
	(generator := UPGGenerator new) context
		withAccessors;
		package: self categoryName.
	cls := self newClassNamed: #SomethingGenerated