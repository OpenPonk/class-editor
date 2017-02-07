tests
testCreateDiagramElement
	| inheritance ic edge |
	inheritance := FAMIXInheritance subclass: child superclass: parent.
	diagramController model add: inheritance.
	diagramController rebuild.
	ic := diagramController controllers last.
	edge := ic diagramElement.

	self assert: edge class equals: OPUmlEdge.
	self assert: edge modelElement equals: inheritance.
	self assert: edge headDecorator equals: RTEmptyNarrowArrow.
	self assert: edge tailDecorator equals: RTNoDecorationShape