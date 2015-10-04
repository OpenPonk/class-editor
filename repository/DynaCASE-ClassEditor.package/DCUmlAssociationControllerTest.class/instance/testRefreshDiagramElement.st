tests
testRefreshDiagramElement
	| association ac edge |
	association := DCFAMIXBinaryAssociation source: target target: source.
	diagramController model add: association.
	diagramController rebuild.
	ac := diagramController controllers last.
	edge := ac diagramElement.
	self assert: ac model equals: association.

	association sourceEnd isNavigable: true.
	ac refreshFigure.
	self assert: edge tailDecorator equals: RTSimpleArrow.

	association targetEnd isNavigable: true.
	ac refreshFigure.
	self assert: edge headDecorator equals: RTSimpleArrow