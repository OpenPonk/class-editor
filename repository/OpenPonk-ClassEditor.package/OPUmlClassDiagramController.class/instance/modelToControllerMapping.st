accessing
modelToControllerMapping
	^ {(FAMIXClass -> OPUmlClassController).
	(FAMIXAttribute -> OPUmlAttributeController).
	(FAMIXMethod -> OPUmlMethodController).
	(OPFAMIXBinaryAssociation -> OPUmlAssociationController).
	(FAMIXInheritance -> OPUmlInheritanceController)} asDictionary