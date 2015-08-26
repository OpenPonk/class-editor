grammar
multiplicityRange
	^ super multiplicityRange
		==>
			[ :nodes | 
			| min max |
			min := nodes first.
			max := nodes second.
			max = $*
				ifTrue: [ max := Float infinity ].
			min
				ifNil: [ 
					min := max isInfinite
						ifTrue: [ 0 ]
						ifFalse: [ max ] ].
			Array with: min with: max ]