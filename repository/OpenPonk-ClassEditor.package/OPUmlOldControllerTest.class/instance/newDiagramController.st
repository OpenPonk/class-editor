instance creation
newDiagramController
	^ OPUmlOldClassDiagramController new
		model: MooseModel new;
		view: RTView new;
		yourself