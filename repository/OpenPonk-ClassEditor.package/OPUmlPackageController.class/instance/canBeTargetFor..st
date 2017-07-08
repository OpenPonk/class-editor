testing
canBeTargetFor: aController
	^ (aController isKindOf: OPUmlGeneralizationController)
		| (aController isKindOf: OPUmlAssociationController)