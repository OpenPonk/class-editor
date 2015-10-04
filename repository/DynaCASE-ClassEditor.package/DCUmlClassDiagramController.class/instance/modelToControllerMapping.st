accessing
modelToControllerMapping
	^ {(FAMIXClass -> DCUmlClassController).
	(FAMIXAttribute -> DCUmlAttributeController).
	(FAMIXMethod -> DCUmlMethodController).
	(DCFAMIXBinaryAssociation -> DCUmlAssociationController).
	(FAMIXInheritance -> DCUmlInheritanceController)} asDictionary