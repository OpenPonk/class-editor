generator - templates
lazyGetter: anEnd
	^ self
		replace: (self class >> #containerLazy) sourceCode
		with:
			{#containerLazy -> anEnd name.
			#container -> anEnd name.
			#_dsl_ -> (self dslFor: anEnd association)}