accessing
typeNameFor: aFamixType
	^ aFamixType ifNil: [ 'Object' ] ifNotNil: [ aFamixType name ]