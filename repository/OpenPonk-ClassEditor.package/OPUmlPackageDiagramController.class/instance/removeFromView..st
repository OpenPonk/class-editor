removing
removeFromView: aFigure
	"Remove a model object represented by aFigure from the model."

	(self controllerForFigure: aFigure) removeModel