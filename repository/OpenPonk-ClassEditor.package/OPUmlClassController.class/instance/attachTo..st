events - registering
attachTo: aDiagramController
	| newModel |
	newModel := self modelClass new.
	newModel name: 'random unused name'.
	OPRenameElementCommand executeOn: newModel.
	aDiagramController model packagedElements add: newModel.
	aDiagramController showModelInDiagram: newModel.