*OpenPonk-UML-DSL
asClassDiagram: aDiagramName
	^ (OPUmlDslParser parse: self)
		name: aDiagramName;
		yourself