accessing
iconMapping
	^ {
	(OPFAMIXBinaryAssociation -> OPUmlIcons current associationIcon).
	(FAMIXInheritance -> OPUmlIcons current generalizationIcon).
	(MooseEntity -> Smalltalk ui theme icons blankIcon).
	(MooseModel -> OPUmlIcons current diagramIcon).
	(FAMIXClass -> OPUmlIcons current classIcon).
	(FAMIXAttribute -> Smalltalk ui theme icons abstractIcon).
	(OPFAMIXStereotype -> Smalltalk ui theme icons blankIcon).
	}