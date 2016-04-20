running
setUp
	super setUp.
	generator := DCUmlEnumGenerator new.
	model := self createEnum.
	generator executeOn: model.
	cls := model smalltalkClass