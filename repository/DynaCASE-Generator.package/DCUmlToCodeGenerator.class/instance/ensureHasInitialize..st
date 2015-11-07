generator - method
ensureHasInitialize: aClass
	(aClass includesSelector: #initialize)
		ifFalse: [ aClass
				compile:
					'initialize
	super initialize'
				classified: 'initialization' ]