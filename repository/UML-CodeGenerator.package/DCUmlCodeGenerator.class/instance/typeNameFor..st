accessing
typeNameFor: aFamixType
	(aFamixType isKindOf: FAMIXAttribute)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	(aFamixType isKindOf: DCFAMIXProperty)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	^ aFamixType ifNil: [ 'Object' ] ifNotNil: [ aFamixType name ]