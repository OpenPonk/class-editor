running
setUp
	super setUp.
	(generator := DCUmlCodeGenerator new) context
		withAccessors;
		package: self categoryName.
	cls := self newClassNamed: #SomethingGenerated