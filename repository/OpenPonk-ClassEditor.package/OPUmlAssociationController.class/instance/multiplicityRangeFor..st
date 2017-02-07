ui hooks
multiplicityRangeFor: aMultiplicity
	aMultiplicity lower = aMultiplicity upper
		ifTrue: [ ^ aMultiplicity printLower ].
	aMultiplicity lower = 0 & aMultiplicity isUnlimited
		ifTrue: [ ^ aMultiplicity printUpper ].
	^ aMultiplicity printLower , '..' , aMultiplicity printUpper