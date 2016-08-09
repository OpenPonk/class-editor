visitor
visitUmlAssociation: anElement
	elements
		at: anElement xmiId
		put: [ DCFAMIXBinaryAssociation new
				name: anElement @ #name;
				instVarNamed: #mooseID put: (self idFrom: anElement xmiId);
				mooseModel: (self elementAt: anElement parent xmiId);
				yourself ]