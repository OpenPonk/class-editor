generator - method
specifyDefaultValueFor: aFamixEntity in: aClass
	aFamixEntity multiplicity upper > 1
		ifTrue:
			[ self
				addToIntialize: ('{1} := OrderedCollection new' format: {aFamixEntity name})
				in: aClass ]