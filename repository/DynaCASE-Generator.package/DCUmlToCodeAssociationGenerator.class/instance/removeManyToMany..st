templates
removeManyToMany: anEnd
	^ self removeManyToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd)
				with: #otherName -> anEnd opposite name
				with: #otherNameSg -> anEnd opposite name asEnglishSingular capitalized)