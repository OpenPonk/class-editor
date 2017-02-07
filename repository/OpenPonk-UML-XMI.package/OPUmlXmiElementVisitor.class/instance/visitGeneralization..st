visitor
visitGeneralization: anElement
	elements
		at: anElement xmiId
		put: [ FAMIXInheritance new
				instVarNamed: #mooseID put: anElement xmiId;
				subclass: (self elementAt: anElement parent xmiId);
				superclass: (self elementAt: anElement @ #general);
				mooseModel: (self elementAt: anElement parent xmiId) mooseModel;
				yourself ].
	self visitChildren: anElement