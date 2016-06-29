generator - templates
setter: anEnd
	^ self
		replace: (self templateNamed: #setter:)
		with:
			{#aValue -> (self paramNameForEnd: anEnd).
			#setter -> anEnd name}