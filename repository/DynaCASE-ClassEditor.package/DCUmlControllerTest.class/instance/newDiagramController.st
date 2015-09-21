instance creation
newDiagramController
	^ DCUmlClassDiagramController new
		model: MooseModel new;
		view: RTView new;
		yourself