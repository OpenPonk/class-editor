printing
printRange
	^ String
		streamContents:
			[ :stream | 
			stream
				nextPut: $[;
				nextPutAll: self lower asString.
			self lower = self upper
				ifFalse:
					[ 
					stream
						nextPutAll: '..';
						nextPutAll:
							(self upper isInfinite
								ifTrue: [ '*' ]
								ifFalse: [ self upper asString ]) ].
			stream nextPut: $] ]