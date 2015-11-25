generator - accessors
createBidirectionalAccessorsFor: anAssociationEnd opposite: anOppositeEnd in: aClass
	self
		createGetter: anAssociationEnd name
		pragma: (self getterPragmaFor: anAssociationEnd)
		in: aClass