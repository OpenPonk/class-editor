*DynaCASE-UML-DSL
asClassDiagram: aDiagramName
	^ (DCUmlDslParser parse: self)
		name: aDiagramName;
		yourself