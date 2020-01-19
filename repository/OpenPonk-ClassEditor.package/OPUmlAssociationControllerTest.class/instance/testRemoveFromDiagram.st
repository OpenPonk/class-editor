tests - diagram
testRemoveFromDiagram
	diagramController
		showModelInDiagram: element;
		showModelInDiagram: comment;
		showModelInDiagram: association.
	controller := diagramController controllerForModel: association.
	self assert: diagramController view edges asArray isNotEmpty.
	controller remove.
	self assert: diagramController view edges asArray equals: #()