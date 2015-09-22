testing
canBeTargetFor: aController
	^ (aController isKindOf: DCUmlAssociationController)
		| (aController isKindOf: DCUmlAttributeController)
		| (aController isKindOf: DCUmlMethodController)