as yet unclassified
modelToControllerMapping
	^ {FAMIXClass -> LUCDClassController.
	FAMIXAttribute -> LUCDAttributeController.
	FAMIXMethod -> LUCDMethodController.
	DCFAMIXBinaryAssociation -> DCUmlAssociationController.
	FAMIXInheritance -> DCUmlInheritanceController} asDictionary