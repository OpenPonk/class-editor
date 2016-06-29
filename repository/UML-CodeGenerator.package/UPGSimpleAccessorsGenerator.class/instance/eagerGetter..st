generator - templates
eagerGetter: anEnd
	^ self
		replace: (self templateNamed: #getter)
		with:
			{#getter -> anEnd name.
			#_dsl_ -> (self dslFor: anEnd association)}