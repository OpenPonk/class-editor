tests
testClassBeTarget
	| sourceController targetController |
	sourceController := diagramController newControllerFor: OPUMLClass new.
	targetController := diagramController newControllerFor: OPUMLClass new.
	diagramController
		addController: sourceController;
		addController: targetController.
	sourceController showInDiagram: diagramController.
	targetController showInDiagram: diagramController.
	sourceController addAsSourceFor: controller.
	targetController addAsTargetFor: controller
	"	self assert: sourceController model generalizations asArray equals: {controller model}.
	self assert: controller model general equals: targetController model"