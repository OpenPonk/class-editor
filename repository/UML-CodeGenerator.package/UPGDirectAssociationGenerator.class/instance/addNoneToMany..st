templates
addNoneToMany: anEnd
	^ self addNoneToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd))