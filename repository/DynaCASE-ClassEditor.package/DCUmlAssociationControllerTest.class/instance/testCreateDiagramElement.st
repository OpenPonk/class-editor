tests
testCreateDiagramElement
	| association ac edge |
	association := DCFAMIXBinaryAssociation source: target target: source.
	diagramController model add: association.
	diagramController rebuild.
	ac := diagramController controllers last.
	edge := ac diagramElement.

	self assert: edge class equals: DCUmlEdge.
	self assert: edge modelElement equals: association.
	self assert: edge headDecorator equals: RTSimpleArrow.
	self assert: edge tailDecorator equals: RTSimpleArrow