tests - model
testRemoveFromModel
	diagramController
		showModelInDiagram: importingNamespace;
		showModelInDiagram: importedPackage;
		showModelInDiagram: packageImport.
	controller := diagramController controllerForModel: packageImport.
	controller removeModel.
	self assert: importedPackage packageImports asArray equals: #()