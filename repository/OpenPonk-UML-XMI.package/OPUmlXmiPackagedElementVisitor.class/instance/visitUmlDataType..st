visitor
visitUmlDataType: anElement
	elements
		at: anElement xmiId
		put: [ FAMIXClass new
				name: anElement @ #name;
				addStereotype: (OPFAMIXStereotype named: 'dataType');
				instVarNamed: #mooseID put: (self idFrom: anElement xmiId);
				mooseModel: (self elementAt: anElement parent xmiId);
				yourself ]