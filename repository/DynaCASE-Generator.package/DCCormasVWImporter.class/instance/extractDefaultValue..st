as yet unclassified
extractDefaultValue: aClass
	aClass methods
		select: [ :each | each name endsWith: '_default' ]
		thenDo: [ :each | 
			| ast |
			ast := each sourceAnchor pharoEntity ast.
			ast lastIsReturn
				ifTrue: [ ast body statements last value value
						ifNotNil: [ :value | self ensureDefaultValue: value fromMethod: each ] ] ]