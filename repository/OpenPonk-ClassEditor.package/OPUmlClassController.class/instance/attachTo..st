events - registering
attachTo: aDiagramController
	| newModel |
	newModel := self modelClass new.
	newModel name: 'New Class'.
	OPRenameElementCommand executeOn: newModel.
	aDiagramController model packagedElements add: newModel.
	aDiagramController showModelInDiagram: newModel.