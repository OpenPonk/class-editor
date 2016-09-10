transforming - utility
multiplicityFor: aMultiplicity
	^ {aMultiplicity printLower asNumber}
		,
			(aMultiplicity lower = aMultiplicity upper
				ifTrue: [ {} ]
				ifFalse:
					[ {(aMultiplicity printUpper = '*'
						ifTrue: [ '*' ]
						ifFalse: [ aMultiplicity upper asNumber ])} ])