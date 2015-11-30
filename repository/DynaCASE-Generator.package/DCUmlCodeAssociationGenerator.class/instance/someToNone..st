templates
someToNone: anEnd
	^ self someToNone
		format: (Dictionary with: #name -> anEnd name with: #param -> (self paramNameForEnd: anEnd))