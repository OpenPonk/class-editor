running
setUp
	super setUp.
	controller := self controllerClass new.
	diagramController := self newDiagramController