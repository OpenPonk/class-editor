running
setUp
	super setUp.
	parent := FAMIXClass named: 'parent'.
	child := FAMIXClass named: 'child'.
	diagramController model add: parent.
	diagramController model add: child.
	diagramController rebuild.
	parentController := diagramController controllers first.
	childController := diagramController controllers second