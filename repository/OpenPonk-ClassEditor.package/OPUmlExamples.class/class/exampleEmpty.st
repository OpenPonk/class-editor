examples
exampleEmpty
	| project diagram |
	project := OPProject named: 'UML Class Diagram'.
	(diagram := MooseModel new) name: 'UML Class Diagram'.
	project addModel: diagram.
	^ OPWorkbench openProject: project