as yet unclassified
createNewModel
	| modelName projectName project model |
	projectName := UIManager default request: 'New model name'.
	modelName := ((projectName splitOn: ' ') collect: #capitalized) joinUsing: ''.
	project := OPProject named: projectName.
	(model := MooseModel new)
		name: projectName;
		isCormasModel: true.
	model
		add:
			((FAMIXClass named: modelName)
				addStereotype: (OPFAMIXStereotype named: 'CormasModel');
				yourself).
	project addModel: model.
	OPWorkbench openProject: project