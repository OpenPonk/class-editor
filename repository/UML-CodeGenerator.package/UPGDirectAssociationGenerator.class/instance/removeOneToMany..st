templates
removeOneToMany: anEnd
	^ self removeOneToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd)
				with: #otherName -> anEnd opposite name)