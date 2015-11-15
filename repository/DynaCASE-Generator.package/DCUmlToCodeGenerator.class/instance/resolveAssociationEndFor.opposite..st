generator - association
resolveAssociationEndFor: anAssociationEnd opposite: anOppositeEnd
	| cls |
	cls := self classFor: anOppositeEnd property name.
	anAssociationEnd isNavigable
		ifFalse:
			[ ^ self
				createNonNavigableGetter: anAssociationEnd name
				pragma: (self getterPragmaFor: anAssociationEnd)
				in: cls ].
	cls addInstVarNamed: anAssociationEnd name.
	self createAccessorsFor: anAssociationEnd in: cls.
	self specifyDefaultValueFor: anAssociationEnd in: cls