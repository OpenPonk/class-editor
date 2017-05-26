as yet unclassified
createModelAndShowInDiagram: aDiagramController
	| newModel |
	newModel := self modelClass new.
	newModel name: 'New Class'.
	OPRenameElementCommand executeOn: newModel.
	model := newModel.
	aDiagramController model packagedElements add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController