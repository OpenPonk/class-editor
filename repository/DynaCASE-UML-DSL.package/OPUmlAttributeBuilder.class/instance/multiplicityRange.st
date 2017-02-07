building
multiplicityRange
	^ super multiplicityRange
		==>
			[ :nodes | 
			| min max |
			min := nodes first.
			max := nodes second.
			max = $*
				ifTrue: [ max := OPUnlimitedNatural max ].
			min
				ifNil: [ 
					min := max = OPUnlimitedNatural max
						ifTrue: [ 0 ]
						ifFalse: [ max ] ].
			Array with: min with: max ]