tests
testAssociations1
	self
		parse:
			'DCDiagram[0..1] owner --- elements DCNamedElement[*];
DCProject[0..1] --- diagrams DCDiagram[*];'
		rule: #statements