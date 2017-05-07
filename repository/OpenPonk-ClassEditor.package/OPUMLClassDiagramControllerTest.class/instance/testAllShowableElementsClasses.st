tests
testAllShowableElementsClasses
	| model |
	(model := OPUMLModel new) packagedElements: {OPUMLClass new}.
	self
		assert: (controller allShowableElementsInModel: model)
		equals: {model packagedElements first}