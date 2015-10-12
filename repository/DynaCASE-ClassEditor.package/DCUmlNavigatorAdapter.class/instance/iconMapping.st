accessing
iconMapping
	^ {
	(DCFAMIXBinaryAssociation -> DCUmlIcons current associationIcon).
	(FAMIXInheritance -> DCUmlIcons current generalizationIcon).
	(MooseEntity -> Smalltalk ui theme icons blankIcon).
	(MooseModel -> DCUmlIcons current diagramIcon).
	(FAMIXClass -> DCUmlIcons current classIcon).
	(FAMIXAttribute -> Smalltalk ui theme icons abstractIcon)}