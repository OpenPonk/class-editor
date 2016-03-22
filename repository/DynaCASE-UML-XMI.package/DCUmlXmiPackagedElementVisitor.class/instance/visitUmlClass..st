visitor
visitUmlClass: anElement
	elements
		at: anElement xmiId
		put: [ FAMIXClass new
				name: anElement @ #name;
				instVarNamed: #mooseID put: anElement xmiId;
				mooseModel: (self elementAt: anElement parent xmiId);
				yourself ]