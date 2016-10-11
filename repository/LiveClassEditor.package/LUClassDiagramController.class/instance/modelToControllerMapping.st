as yet unclassified
modelToControllerMapping
	^ {FAMIXClass -> LUCDClassController.
	FAMIXAttribute -> DCUmlAttributeController.
	FAMIXMethod -> DCUmlMethodController.
	DCFAMIXBinaryAssociation -> DCUmlAssociationController.
	FAMIXInheritance -> DCUmlInheritanceController} asDictionary