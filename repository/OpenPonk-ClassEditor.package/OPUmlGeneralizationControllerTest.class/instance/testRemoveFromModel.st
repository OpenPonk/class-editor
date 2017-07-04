tests - model
testRemoveFromModel
	diagramController
		showModelInDiagram: parent;
		showModelInDiagram: child;
		showModelInDiagram: generalization.
	controller := diagramController controllerForModel: generalization.
	controller removeModel.
	self assert: child generalizations asArray equals: #()