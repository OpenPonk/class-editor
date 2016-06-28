generator - templates
setter: anEnd
	^ self
		replace: (self class >> #container:) sourceCode
		with:
			{#aValue -> (self paramNameForEnd: anEnd).
			#container -> anEnd name}