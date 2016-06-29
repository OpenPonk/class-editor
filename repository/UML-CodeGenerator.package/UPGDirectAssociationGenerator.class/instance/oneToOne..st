templates
oneToOne: anEnd
	^ self oneToOne
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #param -> (self paramNameForEnd: anEnd)
				with: #otherName -> anEnd opposite name)