instance creation
newDiagramController
	^ OPUmlClassDiagramController new
		model: MooseModel new;
		view: RTView new;
		yourself