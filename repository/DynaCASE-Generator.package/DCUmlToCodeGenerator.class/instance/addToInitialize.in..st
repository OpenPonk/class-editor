generator - method
addToInitialize: aCodeString in: aClass
	| node |
	self ensureHasInitialize: aClass.
	node := RBParser parseExpression: aCodeString.
	((aClass >> #initialize) ast body statements includes: node)
		ifTrue: [ ^ self ].
	aClass compile: (aClass >> #initialize) sourceCode , '.' , aCodeString.
	(aClass >> #initialize) reformat