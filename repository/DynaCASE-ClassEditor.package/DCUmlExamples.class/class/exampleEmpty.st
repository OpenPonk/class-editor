examples
exampleEmpty
	| project diagram |
	project := DCProject named: 'UML Class Diagram'.
	(diagram := MooseModel new) name: 'UML Class Diagram'.
	project addDiagram: diagram.
	DCWorkbench openProject: project