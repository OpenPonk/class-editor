tests - diagram
testShowInDiagram
	diagramController
		showModelInDiagram: importingNamespace;
		showModelInDiagram: importedPackage.
	diagramController showModelInDiagram: packageImport.
	self
		assert:
			(diagramController view edges
				anySatisfy: [ :each | each model isNotNil and: [ each model modelElement = packageImport ] ])