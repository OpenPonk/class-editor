tests - diagram
testShowInDiagram
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
	self
		assert:
			(diagramController view edges
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = gen ] ])