running
setUp
	super setUp.
	(generator := DCUmlCodeGenerator new) context
		withAccessors;
		category: self categoryName.
	cls := self newClassNamed: #SomethingGenerated