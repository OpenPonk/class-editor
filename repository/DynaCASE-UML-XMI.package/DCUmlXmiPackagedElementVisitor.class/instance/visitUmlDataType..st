visitor
visitUmlDataType: anElement
	elements
		at: anElement xmiId
		put: [ FAMIXClass new
				name: anElement @ #name;
				addStereotype: (DCFAMIXStereotype named: 'dataType');
				instVarNamed: #mooseID put: anElement xmiId;
				mooseModel: (self elementAt: anElement parent xmiId);
				yourself ]