tests - diagram
testRemoveFromDiagram
	| parent child gen |
	parent := OPUMLClass new.
	child := OPUMLClass new.
	gen := OPUMLGeneralization new.
	gen
		general: parent;
		specific: child.
	diagramController
		showModelInDiagram: parent;
		showModelInDiagram: child.
	diagramController showModelInDiagram: gen.
	controller := diagramController controllerForModel: gen.
	controller remove.
	self assert: diagramController view edges asArray equals: #()