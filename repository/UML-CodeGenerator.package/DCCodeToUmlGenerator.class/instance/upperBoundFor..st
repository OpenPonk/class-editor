generator - attribute
upperBoundFor: aPragma
	aPragma arguments second
		ifNotEmpty:
			[ :range | 
			range size = 1
				ifTrue:
					[ range first = '*'
						ifTrue: [ ^ DCUnlimitedNatural max ]
						ifFalse: [ ^ range first ] ]
				ifFalse:
					[ range second = '*'
						ifTrue: [ ^ DCUnlimitedNatural max ]
						ifFalse: [ ^ range second ] ] ].
	^ 1