accessing
modelToControllerMapping
	^ {(FAMIXClass -> DCUmlClassController).
	(FAMIXAttribute -> DCUmlAttributeController).
	(DCUmlAssociation -> DCUmlAssociationController).
	(DCUmlGeneralization -> DCUmlGeneralizationController)} asDictionary