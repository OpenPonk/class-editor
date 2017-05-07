tests
testAllShowableElementsClassesWithProperties
	| model class attr op |
	attr := OPUMLProperty new.
	op := OPUMLOperation new.
	class := OPUMLClass new.
	class attributes: {attr}.
	class ownedOperations: {op}.
	(model := OPUMLModel new) packagedElements: {class}.
	self
		assert: (controller allShowableElementsInModel: model)
		equals:
			{class.
			attr.
			"op"}