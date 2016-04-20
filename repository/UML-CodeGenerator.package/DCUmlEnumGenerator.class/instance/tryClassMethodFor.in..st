accessing
tryClassMethodFor: aPair in: aClass
	"Class side is a minefield so be extra careful."

	| method |
	(Object respondsTo: aPair key)
		ifTrue: [ ^ self ].
	method := '{1}
	"Generated method"

	^ self enum {1}' format: {aPair key}.
	((aClass class includesSelector: aPair key)
		and: [ (aClass class >> aPair key) sourceCode = method ])
		ifFalse: [ aClass class compile: method classified: 'accessing - literals' ]