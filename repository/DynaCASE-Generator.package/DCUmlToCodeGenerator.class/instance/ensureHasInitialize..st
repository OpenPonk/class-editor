generator - method
ensureHasInitialize: aClass
	(aClass selectors includes: #initialize)
		ifFalse:
			[ aClass
				compile:
					'initialize
	super initialize'
				classified: 'initialization' ]