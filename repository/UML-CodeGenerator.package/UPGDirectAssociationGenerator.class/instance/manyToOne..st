templates
manyToOne: anEnd
	^ self manyToOne
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #otherNameSgCapitalized -> anEnd opposite name asEnglishSingular capitalized
				with: #otherNameSg -> anEnd opposite name asEnglishSingular
				with: #param -> (self paramNameForEnd: anEnd))