*DynaCASE-ClassEditor
openAs: aProjectName
	DCProject new
		projectName: aProjectName;
		addDiagram: self;
		open