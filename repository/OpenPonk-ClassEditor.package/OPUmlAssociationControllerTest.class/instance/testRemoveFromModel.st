tests - model
testRemoveFromModel
	diagramController
		showModelInDiagram: element;
		showModelInDiagram: comment;
		showModelInDiagram: association.
	controller := diagramController controllerForModel: association.
	diagramController model packagedElements add: association.
	self assert: ownedComment association equals: association.
	self assert: ownedComment owningClass equals: element.
	controller removeModel.
	self assert: ownedComment association equals: nil.
	self assert: ownedComment owningClass equals: nil