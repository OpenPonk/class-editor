running
setUp
	super setUp.
	(generator := DCUmlToCodeGenerator new)
		withAccessors;
		defaultCategory: self categoryName.
	cls := self newClassNamed: #SomethingGenerated