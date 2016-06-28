generator - templates
remover: anEnd
	^ self
		replace: (self class >> #removeValue:) sourceCode
		with:
			{#removeValue: -> ('remove' , anEnd name asEnglishSingular capitalized , ':').
			#aValue -> (self typeNameForEnd: anEnd).
			#container -> anEnd name}