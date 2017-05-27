adding
canBeTargetFor: aController
	^ (aController isKindOf: OPUmlAttributeController)
		| (aController isKindOf: OPUmlOperationController)