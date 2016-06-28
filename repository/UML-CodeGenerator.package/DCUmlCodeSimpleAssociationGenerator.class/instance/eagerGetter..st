generator - templates
eagerGetter: anEnd
	^ self
		replace: (self class >> #container) sourceCode
		with:
			{#container -> anEnd name.
			#_dsl_ -> (self dslFor: anEnd association)}