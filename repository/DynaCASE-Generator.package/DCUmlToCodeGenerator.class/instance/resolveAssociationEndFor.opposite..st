generator - association
resolveAssociationEndFor: anAssociationEnd opposite: anOppositeEnd
	anAssociationEnd isNavigable
		ifFalse: [ ^ self ].
	self createAccessorsFor: anAssociationEnd in: (self classFor: anOppositeEnd property name).
	self
		specifyDefaultValueFor: anAssociationEnd
		in: (self classFor: anOppositeEnd property name)