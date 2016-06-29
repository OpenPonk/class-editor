templates
getter: anEnd
	^ self getter
		format: (Dictionary with: #name -> anEnd name with: #dsl -> (self dslFor: anEnd association))