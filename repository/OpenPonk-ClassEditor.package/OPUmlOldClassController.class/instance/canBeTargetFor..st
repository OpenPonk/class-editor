testing
canBeTargetFor: aController
	^ (aController isKindOf: OPUmlOldAssociationController)
		| (aController isKindOf: OPUmlOldAttributeController)
		| (aController isKindOf: OPUmlOldMethodController)
		| (aController isKindOf: OPUmlOldRelationshipController)