tests - model
testRemoveFromModel
	diagramController
		showModelInDiagram: element;
		showModelInDiagram: comment;
		showModelInDiagram: association.
	controller := diagramController controllerForModel: association.
	controller removeModel.
	self assert: ownedComment association equals: nil