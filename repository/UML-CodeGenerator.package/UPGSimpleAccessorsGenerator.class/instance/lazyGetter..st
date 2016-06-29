generator - templates
lazyGetter: anEnd
	^ self
		replace: (self templateNamed: #lazyGetter)
		with:
			{#lazyGetter -> anEnd name.
			#getter -> anEnd name.
			#_dsl_ -> (self dslFor: anEnd association)}