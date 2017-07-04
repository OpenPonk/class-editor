tests
testClassBeTarget
	| sourceController targetController |
	sourceController := diagramController newControllerFor: (OPUMLClass new name: 'A').
	targetController := diagramController newControllerFor: (OPUMLClass new name: 'B').
	diagramController
		addController: sourceController;
		addController: targetController.
	sourceController showInDiagram: diagramController.
	targetController showInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	targetController addAsTargetFor: controller.
	self assert: (controller model memberEnds collect: #name) asArray equals: #(a b)