tests
testRefreshDiagramElement
	| association ac edge |
	association := DCFAMIXBinaryAssociation source: target target: source.
	diagramController model add: association.
	diagramController rebuild.
	ac := diagramController controllers last.
	edge := ac diagramElement.
	self assert: ac model equals: association.
	association targetEnd isNavigable: true.
	association sourceEnd isNavigable: false.
	ac refreshFigure.
	self assert: edge headDecorator equals: RTSimpleArrow.
	self assert: edge tailDecorator equals: RTNoDecorationShape.
	association targetEnd isNavigable: false.
	association sourceEnd isNavigable: true.
	ac refreshFigure.
	self assert: edge headDecorator equals: RTNoDecorationShape.
	self assert: edge tailDecorator equals: RTSimpleArrow