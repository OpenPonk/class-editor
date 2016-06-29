generator - templates
adder: anEnd
	^ self
		replace: (self templateNamed: #adder:)
		with:
			{#adder: -> ('add' , anEnd name asEnglishSingular capitalized , ':').
			#aValue -> (self typeNameForEnd: anEnd).
			#container -> anEnd name}