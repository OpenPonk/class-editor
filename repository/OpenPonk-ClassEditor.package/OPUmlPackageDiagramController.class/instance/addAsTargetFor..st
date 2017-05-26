adding
addAsTargetFor: aClassController
	self assert: (self canBeTargetFor: aClassController).
	aClassController createModelAndShowInDiagram: self