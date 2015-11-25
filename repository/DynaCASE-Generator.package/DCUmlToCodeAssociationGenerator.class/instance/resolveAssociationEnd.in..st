generator - association
resolveAssociationEnd: anAssociationEnd in: aClass
	anAssociationEnd isNavigable
		ifFalse: [ ^ self ].
	aClass addInstVarNamed: anAssociationEnd name.
	self createAccessorsFor: anAssociationEnd in: aClass.
	self specifyDefaultValueFor: anAssociationEnd in: aClass