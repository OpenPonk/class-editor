accessing
iconMapping
	^ {DCUmlClassDiagram -> DCUmlIcons current diagramIcon.
	DCUmlClass -> DCUmlIcons current classIcon.
	DCUmlAssociation -> DCUmlIcons current associationIcon.
	DCUmlGeneralization -> DCUmlIcons current generalizationIcon}