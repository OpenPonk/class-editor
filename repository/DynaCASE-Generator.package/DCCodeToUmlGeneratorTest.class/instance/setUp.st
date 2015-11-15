running
setUp
	super setUp.
	cls := self newClassNamed: #SomethingEmpty.
	generator := DCCodeToUmlGenerator new