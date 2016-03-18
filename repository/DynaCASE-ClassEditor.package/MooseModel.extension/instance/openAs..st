*DynaCASE-ClassEditor
openAs: aProjectName
	DCProject new
		projectName: aProjectName;
		addModel: self;
		open