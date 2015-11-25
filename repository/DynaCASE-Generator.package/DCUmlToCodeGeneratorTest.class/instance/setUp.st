running
setUp
	super setUp.
	(generator := DCUmlToCodeMixedGenerator new)
		withAccessors;
		defaultCategory: self categoryName.
	cls := self newClassNamed: #SomethingGenerated