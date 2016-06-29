running
setUp
	super setUp.
	generator := UPGEnumGenerator new.
	model := self createEnum.
	generator executeOn: model.
	cls := model smalltalkClass