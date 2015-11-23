examples
sampleDsl
	^ DCUmlDslParser
		parse:
			'
	DCProject {
		addDiagram(aDiagram : DCDiagram)
		layoutFor(aDiagram : DCDiagram) : Dictionary
	}
	DCDiagram {  }
	DCNamedElement {  }
	DCModelObject {
		dcID : UUID
		dcName : String
	}
	
	DCNamedElement << DCModelObject;
	DCDiagram extends DCModelObject;
	
	DCDiagram[0..1] owner --- elements DCNamedElement[*];
	DCProject[0..1] --- diagrams DCDiagram[*];
	DCModelObject[*] --- owner DCModelObject[0..1];
'