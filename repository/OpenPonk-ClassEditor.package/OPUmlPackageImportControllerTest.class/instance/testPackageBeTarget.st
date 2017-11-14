tests - construction
testPackageBeTarget
	| sourceController targetController |
	sourceController := diagramController newControllerFor: (OPUMLPackage new name: 'A').
	targetController := diagramController newControllerFor: (OPUMLPackage new name: 'B').
	diagramController
		addController: sourceController;
		addController: targetController.
	sourceController showInDiagram: diagramController.
	targetController showInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	targetController addAsTargetFor: controller.
	self assert: sourceController model packageImports asArray equals: {controller model}.
	self assert: controller model importedPackage equals: targetController model