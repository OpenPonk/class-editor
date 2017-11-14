accessing
layouter
	^ layouter ifNil: [ layouter := OPUmlLayouter new diagramController: self ]