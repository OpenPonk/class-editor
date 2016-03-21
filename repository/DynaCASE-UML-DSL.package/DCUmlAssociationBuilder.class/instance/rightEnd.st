accessing
rightEnd
	^ super rightEnd
		==> [ :n | 
			| nodes |
			nodes := Array
				with:
					(n second isArray
						ifTrue: [ n second second ]
						ifFalse: [ n second ])
				with: n third
				with:
					(n second isArray
						ifTrue: [ n second first ]
						ifFalse: [ nil ])
				with: n first.
			{nodes first.
			(DCFAMIXProperty new
				name: nodes third;
				multiplicity: nodes second).
			nodes fourth first.
			nodes fourth second} ]