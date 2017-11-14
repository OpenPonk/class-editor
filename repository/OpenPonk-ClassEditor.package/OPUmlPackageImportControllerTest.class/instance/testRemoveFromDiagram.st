tests - diagram
testRemoveFromDiagram
	diagramController
		showModelInDiagram: importingNamespace;
		showModelInDiagram: importedPackage.
	diagramController showModelInDiagram: packageImport.
	controller := diagramController controllerForModel: packageImport.
	controller remove.
	self assert: diagramController view edges asArray equals: #()