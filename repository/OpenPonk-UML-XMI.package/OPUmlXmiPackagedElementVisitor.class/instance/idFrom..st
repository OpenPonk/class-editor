as yet unclassified
idFrom: aString
	(NumberParser isNumber: aString)
		ifTrue: [ ^ aString asNumber ].
	^ aString