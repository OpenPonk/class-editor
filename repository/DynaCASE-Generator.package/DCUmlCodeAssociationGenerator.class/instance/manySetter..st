templates
manySetter: anEnd
	^ self manySetter
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self paramNameForEnd: anEnd))