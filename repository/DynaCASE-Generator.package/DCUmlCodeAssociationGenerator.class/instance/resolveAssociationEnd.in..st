generator - association
resolveAssociationEnd: anAssociationEnd in: aClass
	anAssociationEnd isNavigable
		ifFalse: [ ^ self ].
	(anAssociationEnd name isNil or: [ anAssociationEnd name isEmpty ])
		ifTrue: [ self flag: 'Better error handling'.
			self logCr: 'Association end doesn''t have a name'.
			^ self ].
	self ensureInstVariable: anAssociationEnd name in: aClass.
	self createAccessorsFor: anAssociationEnd in: aClass.
	self addEagerValueFor: anAssociationEnd in: aClass