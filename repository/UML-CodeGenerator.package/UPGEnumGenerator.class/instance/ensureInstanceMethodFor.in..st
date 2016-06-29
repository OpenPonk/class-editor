accessing
ensureInstanceMethodFor: aPair in: aClass
	| method |
	method := '{1}
	"Generated method"

	^ {2}'
		format:
			{aPair key.
			aPair value}.
	((aClass includesSelector: aPair key)
		and: [ (aClass >> aPair key) sourceCode = method ])
		ifFalse: [ aClass compile: method classified: 'accessing - literals' ]