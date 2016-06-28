generator - templates
adder: anEnd
	^ self
		replace: (self class >> #addValue:) sourceCode
		with:
			{#addValue: -> ('add' , anEnd name asEnglishSingular capitalized , ':').
			#aValue -> (self typeNameForEnd: anEnd).
			#container -> anEnd name}