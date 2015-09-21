accessing
iconMapping
	^ {(DCUmlClassDiagram -> DCUmlIcons current diagramIcon).
	(DCUmlClass -> DCUmlIcons current classIcon).
	(DCUmlAssociation -> DCUmlIcons current associationIcon).
	(DCUmlGeneralization -> DCUmlIcons current generalizationIcon).
	(MooseEntity -> Smalltalk ui theme icons blankIcon).
	(MooseModel -> DCUmlIcons current diagramIcon).
	(FAMIXClass -> DCUmlIcons current classIcon).
	(FAMIXAttribute -> Smalltalk ui theme icons abstractIcon)}