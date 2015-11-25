generator - association
resolveAssociationEnd: anAssociationEnd
	"anAssociationEnd points to the other class than we are working on"

	| cls |
	cls := self classFor: anAssociationEnd opposite property name.
	anAssociationEnd isNavigable
		ifFalse: [ 'do nothing' ].
	cls addInstVarNamed: anAssociationEnd name.
	self createAccessorsFor: anAssociationEnd in: cls.
	self specifyDefaultValueFor: anAssociationEnd in: cls