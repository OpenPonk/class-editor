instance creation
createAndOpenEmptyEditor
	model := OPUMLPackage new.
	model name: 'Click Package'.
	project := OPUmlProject new.
	project name: 'Click Project'.
	project addModel: model.
	workbench := OPWorkbench new.
	window := workbench open.
	workbench openProject: project.
	editor := (workbench instVarNamed: #editors) values first first.
	view := editor canvasModel roassalView.
	paletteEntries := editor paletteModel widgets select: [ :each | each isKindOf: OPPaletteEntry ]