printing
printRange
	^ String
		streamContents:
			[ :stream | 
			stream nextPut: $[.
			self lower = 0 & (self upper = DCUnlimitedNatural max)
				ifTrue: [ stream nextPutAll: '*' ]
				ifFalse:
					[ stream nextPutAll: self printLower.
					self lower = self upper
						ifFalse: [ stream
								nextPutAll: '..';
								nextPutAll: self printUpper ] ].
			stream nextPut: $] ]