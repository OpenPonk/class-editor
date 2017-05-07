mocks
connectedControllerOn: aModel
	^ OPUmlClassDiagramController new
		model: aModel;
		view: RTView new;
		yourself