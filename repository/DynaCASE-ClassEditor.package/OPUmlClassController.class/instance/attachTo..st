adding
attachTo: aDiagramController
	super attachTo: aDiagramController.
	aDiagramController ensureInModel: self model.
	self attachProperties.
	self attachInheritances.
	self attachAssociations