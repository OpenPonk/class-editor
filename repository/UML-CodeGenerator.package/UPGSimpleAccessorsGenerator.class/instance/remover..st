generator - templates
remover: anEnd
	^ self
		replace: (self templateNamed: #remover:)
		with:
			{#remover: -> ('remove' , anEnd name asEnglishSingular capitalized , ':').
			#aValue -> (self typeNameForEnd: anEnd).
			#container -> anEnd name}