generator - association
resolveAssociationEndFor: anAssociationEnd opposite: anOppositeEnd
	| cls |
	anAssociationEnd isNavigable
		ifFalse: [ ^ self ].
	cls := self classFor: anOppositeEnd property name.
	cls addInstVarNamed: anAssociationEnd name.
	self createAccessorsFor: anAssociationEnd in: cls.
	self specifyDefaultValueFor: anAssociationEnd in: cls