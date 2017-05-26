running
setUp
	super setUp.
	controller := self controllerClass new.
	diagramController := OPUmlPackageDiagramController new.
	diagramController view: RTView new