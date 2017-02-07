transforming - utility
typeNameFor: aFamixType
	(aFamixType isKindOf: FAMIXAttribute)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	(aFamixType isKindOf: OPFAMIXProperty)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	^ aFamixType ifNil: [ 'Object' ] ifNotNil: [ aFamixType name ]