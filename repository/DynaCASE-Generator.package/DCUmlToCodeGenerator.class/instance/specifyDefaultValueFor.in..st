generator - method
specifyDefaultValueFor: aFamixEntity in: aClass
	aFamixEntity multiplicity upper > 1
		ifTrue:
			[ self
				appendToInitialize: ('{1} := OrderedCollection new' format: {aFamixEntity name})
				in: aClass ]