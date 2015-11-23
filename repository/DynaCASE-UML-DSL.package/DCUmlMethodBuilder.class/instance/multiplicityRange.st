grammar
multiplicityRange
	^ super multiplicityRange
		==>
			[ :nodes | 
			| min max |
			min := nodes first.
			max := nodes second.
			max = $*
				ifTrue: [ max := DCUnlimitedNatural max ].
			min
				ifNil: [ 
					min := max = DCUnlimitedNatural max
						ifTrue: [ 0 ]
						ifFalse: [ max ] ].
			Array with: min with: max ]