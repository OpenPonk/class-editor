as yet unclassified
asStringOfType: aFamixType
	aFamixType
		ifNotNil: [ aFamixType name = 'String'
				ifTrue: [ ^ '"' , self valueExpression , '"' ] ].
	^ self valueExpression