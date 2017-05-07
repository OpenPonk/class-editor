tests
testNewController
	self
		assert: (controller newControllerFor: OPUMLClass new) class
		equals: OPUmlClassController