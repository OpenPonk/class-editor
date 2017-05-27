construction
createModelIn: aPackageController andShowInDiagram: aDiagramController
	| newModel |
	newModel := self modelClass new.
	newModel name: 'New Class'.
	model := newModel.
	aDiagramController model packagedElements add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController