testing
canBeSourceFor: aController
	^ (aController isKindOf: OPUmlGeneralizationController)
		| (aController isKindOf: OPUmlAssociationController)