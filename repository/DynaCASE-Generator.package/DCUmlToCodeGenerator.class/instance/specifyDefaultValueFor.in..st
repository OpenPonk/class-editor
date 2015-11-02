generators
specifyDefaultValueFor: aFamixAttribute in: aClass
	aFamixAttribute multiplicity upper > 1
		ifTrue:
			[ self
				appendToInitialize: ('{1} := OrderedCollection new' format: {aFamixAttribute name})
				in: aClass ]