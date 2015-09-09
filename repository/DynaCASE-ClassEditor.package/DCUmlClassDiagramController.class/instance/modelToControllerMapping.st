accessing
modelToControllerMapping
	^ {(FAMIXClass -> DCUmlClassController).
	(DCUmlAssociation -> DCUmlAssociationController).
	(DCUmlGeneralization -> DCUmlGeneralizationController)} asDictionary