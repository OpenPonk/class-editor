templates
manyToOne: anEnd
	^ self manyToOne
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #otherNameSg -> anEnd opposite name asEnglishSingular capitalized
				with: #param -> (self paramNameForEnd: anEnd))