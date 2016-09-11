as yet unclassified
createNewModel
	| modelName projectName project model |
	projectName := UIManager default request: 'New model name'.
	modelName := ((projectName splitOn: ' ') collect: #capitalized) joinUsing: ''.
	project := DCProject named: projectName.
	(model := MooseModel new)
		name: projectName;
		isCormasModel: true.
	model
		add:
			((FAMIXClass named: modelName)
				addStereotype: (DCFAMIXStereotype named: 'CormasModel');
				yourself).
	project addModel: model.
	DCWorkbench openProject: project