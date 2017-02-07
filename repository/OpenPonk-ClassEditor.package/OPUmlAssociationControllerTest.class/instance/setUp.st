running
setUp
	super setUp.
	target := FAMIXClass named: 'parent'.
	source := FAMIXClass named: 'child'.
	diagramController model add: target.
	diagramController model add: source.
	diagramController rebuild.
	targetController := diagramController controllers first.
	sourceController := diagramController controllers second