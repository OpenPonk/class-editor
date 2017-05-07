tests
testAllShowableElements
	self assert: (controller allShowableElementsInModel: OPUMLModel new) asArray equals: #()