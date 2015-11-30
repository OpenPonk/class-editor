accessing
typeNameFor: aFamixType
	(aFamixType isKindOf: FAMIXAttribute)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	(aFamixType isKindOf: DCFAMIXAssociationEnd)
		ifTrue: [ ^ self typeNameFor: aFamixType property ].
	^ aFamixType ifNil: [ 'Object' ] ifNotNil: [ aFamixType name ]