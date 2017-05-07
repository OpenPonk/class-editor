accessing
modelToControllerMapping
	^ {(FAMIXClass -> OPUmlOldClassController).
	(FAMIXAttribute -> OPUmlOldAttributeController).
	(FAMIXMethod -> OPUmlOldMethodController).
	(OPFAMIXBinaryAssociation -> OPUmlOldAssociationController).
	(FAMIXInheritance -> OPUmlOldInheritanceController)} asDictionary