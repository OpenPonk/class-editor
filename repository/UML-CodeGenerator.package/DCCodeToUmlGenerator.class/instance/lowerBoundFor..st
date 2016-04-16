generator - attribute
lowerBoundFor: aPragma
	aPragma arguments second
		ifNotEmpty:
			[ :range | 
			^ range size = 1
				ifTrue: [ range first = '*'
						ifTrue: [ 0 ]
						ifFalse: [ range first ] ]
				ifFalse: [ range first ] ].
	^ 1