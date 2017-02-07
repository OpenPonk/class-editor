accessing
modelToControllerMapping
	^ {(FAMIXClass -> OPUmlClassController).
	(FAMIXAttribute -> OPUmlAttributeController).
	(FAMIXMethod -> OPUmlMethodController).
	(DCFAMIXBinaryAssociation -> OPUmlAssociationController).
	(FAMIXInheritance -> OPUmlInheritanceController)} asDictionary