generator - accessors
getterPragmaFor: aFamixEntity
	(aFamixEntity isKindOf: FAMIXAttribute)
		ifTrue: [ ^ self attributeGetterPragmaFor: aFamixEntity ].
	(aFamixEntity isKindOf: DCFAMIXAssociationEnd)
		ifTrue: [ ^ self associationGetterPragmaFor: aFamixEntity ]