generator - association
resolveAssociationEnd: anAssociationEnd in: aClass
	anAssociationEnd isNavigable
		ifFalse: [ ^ self ].
	self ensureInstVariable: anAssociationEnd name in: aClass.
	self createAccessorsFor: anAssociationEnd in: aClass.
	self addEagerValueFor: anAssociationEnd in: aClass