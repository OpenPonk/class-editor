generator - method
specifyDefaultValueFor: aFamixEntity in: aClass
	(aFamixEntity isAttribute and: [ aFamixEntity defaultValue isNotNil ])
		ifTrue:
			[ ^ self
				addToInitialize:
					('{1} := {2}'
						format: (Array with: aFamixEntity name with: aFamixEntity defaultValue valueExpression))
				in: aClass ].
	aFamixEntity multiplicity upper > 1
		ifTrue:
			[ self
				addToInitialize: ('{1} := OrderedCollection new' format: {aFamixEntity name})
				in: aClass ]