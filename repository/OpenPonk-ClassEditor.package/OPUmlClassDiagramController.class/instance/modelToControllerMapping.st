adding
modelToControllerMapping
	^ {OPUMLClass -> OPUmlClassController.
	OPUMLProperty -> OPUmlAttributeController.
	OPUMLOperation -> OPUmlOperationController.
	OPUMLGeneralization -> OPUmlGeneralizationController.
	OPUMLAssociation -> OPUmlAssociationController} asDictionary