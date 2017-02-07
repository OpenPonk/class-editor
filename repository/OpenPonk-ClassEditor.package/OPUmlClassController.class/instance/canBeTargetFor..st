testing
canBeTargetFor: aController
	^ (aController isKindOf: OPUmlAssociationController)
		| (aController isKindOf: OPUmlAttributeController)
		| (aController isKindOf: OPUmlMethodController)
		| (aController isKindOf: OPUmlRelationshipController)