examples
exampleCormas
	| model diagramInterchange |
	model := self sampleCormas.
	model name: 'MyECEC'.
	"	diagramInterchange := self sampleDslDIFor: model."
	OPProject new
		projectName: 'My ECEC';
		addModel: model;
		"		layout: diagramInterchange for: model;"
			open