tests - model
testRemoveFromModel
	| parent child gen |
	parent := OPUMLClass new.
	child := OPUMLClass new.
	gen := OPUMLGeneralization new.
	gen
		general: parent;
		specific: child.
	diagramController
		showModelInDiagram: parent;
		showModelInDiagram: child;
		showModelInDiagram: gen.
	controller := diagramController controllerForModel: gen.
	controller removeModel.
	self assert: child generalizations asArray equals: #()