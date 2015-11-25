running
setUp
	super setUp.
	(generator := DCUmlToCodeGenerator new)
		withAccessors;
		category: self categoryName.
	cls := self newClassNamed: #SomethingGenerated