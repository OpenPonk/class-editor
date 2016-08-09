visitor
visitUmlClass: anElement
	elements
		at: anElement xmiId
		put: [ FAMIXClass new
				name: anElement @ #name;
				instVarNamed: #mooseID put: (self idFrom: anElement xmiId);
				mooseModel: (self elementAt: anElement parent xmiId);
				isAbstract: anElement @ #isAbstract = 'true';
				yourself ]