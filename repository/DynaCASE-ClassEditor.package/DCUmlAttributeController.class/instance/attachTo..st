events - registering
attachTo: aDiagramController
	super attachTo: aDiagramController.
	aDiagramController ensureInModel: self model.
	classController refreshFigure