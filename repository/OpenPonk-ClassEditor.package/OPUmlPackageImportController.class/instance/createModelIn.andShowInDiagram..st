figures
createModelIn: aTargetController andShowInDiagram: aDiagramController
	self model: OPUMLPackageImport new.
	model importedPackage: aTargetController model.
	model importingNamespace: sourceController model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController