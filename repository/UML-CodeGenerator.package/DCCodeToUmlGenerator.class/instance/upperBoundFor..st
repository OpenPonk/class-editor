generator - attribute
upperBoundFor: aPragma
	aPragma arguments second
		ifNotEmpty: [ :range | 
			range size = 1
				ifTrue: [ range first = '*'
						ifTrue: [ ^ OPUnlimitedNatural max ]
						ifFalse: [ ^ range first ] ]
				ifFalse: [ range second = '*'
						ifTrue: [ ^ OPUnlimitedNatural max ]
						ifFalse: [ ^ range second ] ] ].
	^ 1