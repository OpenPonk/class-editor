examples
exampleDsl
	| model diagramInterchange |
	"temporarily not supported (DSL has to convert to UML from FAMIX)"
	true
		ifTrue: [ ^ self ].
	model := self sampleDsl.
	diagramInterchange := self sampleDslDIFor: model.
	^ OPProject new
		projectName: 'University Model';
		addModel: model;
		layout: diagramInterchange for: model;
		open