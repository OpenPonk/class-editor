helpers
classNameFor: aString
	self context shouldAlwaysUsePrefix not
		and: [ ((Smalltalk hasClassNamed: aString)
				and: [ (aString asClass package name = self context package) not ])
				ifTrue: [ ^ aString ] ].
	^ self context prefix , aString